# Flow: Deploy a Azure

## Rol del Team Leader

El líder decide cuándo publicar a producción. Nadie hace deploy sin su instrucción.
El deploy afecta al ecosistema completo — el líder valida que DB, REST y Microservicios estén alineados antes de publicar.

---

## Estrategia actual

Dos workflows separados en reloaderproject-rest:

- `build.yml` → valida compilación (push a main)
- `deploy.yml` → publica a Azure (solo con tag `deploy-*`)

---

## Build (sin deploy)

`build.yml` corre en:
- `push` a `main`
- `pull_request`

Hace: checkout → Java 17 → `mvn clean package`

No hace: docker push ni deploy a Azure.

---

## Deploy (cuando el líder lo decide)

`deploy.yml` corre solo con tags `deploy-*`.

```bash
git -C "C:/Users/resem/Documents/ProjectReloader/reloaderproject-rest" checkout main
git -C "C:/Users/resem/Documents/ProjectReloader/reloaderproject-rest" pull
git -C "C:/Users/resem/Documents/ProjectReloader/reloaderproject-rest" tag deploy-1.0.X
git -C "C:/Users/resem/Documents/ProjectReloader/reloaderproject-rest" push origin deploy-1.0.X
```

Eso dispara en GitHub Actions:
1. checkout
2. setup Java 17
3. `mvn clean package`
4. login a ACR
5. build Docker
6. push al ACR
7. deploy a Azure Web App

---

## Checklist antes de hacer deploy

El líder verifica antes de aprobar:

- [ ] Migraciones de ReloaderDB aplicadas en producción (Azure SQL)
- [ ] Build local exitoso (`mvn clean package` sin errores)
- [ ] Health local OK (`http://localhost:8080/health`)
- [ ] Versión del tag incrementada correctamente

---

## Migraciones en producción (antes del deploy REST)

Si hay migraciones nuevas, aplicarlas primero:

```bash
flyway -url="jdbc:sqlserver://reloader-db-server.database.windows.net:1433;databaseName=reloader-games-db;encrypt=true;trustServerCertificate=false;loginTimeout=30" \
       -user=<usuario-prod> \
       -password=<password-prod> \
       -locations=filesystem:C:/Users/resem/Documents/GitHub/ReloaderDB/migrations \
       migrate
```

Fuente de verdad: `ReloaderDB/migrations/` — nunca `reloaderproject-rest/db/migrations`.

---

## Deploy manual (cuando no se usa el pipeline)

```bash
# 1. Build WAR
mvn -f "C:/Users/resem/Documents/ProjectReloader/reloaderproject-rest/pom.xml" clean package

# 2. Build imagen (incrementar N manualmente)
docker build -t reloader-backend:1.0.<N> "C:/Users/resem/Documents/ProjectReloader/reloaderproject-rest/"

# 3. Login al ACR
az acr login --name reloaderprodacr

# 4. Tag + Push
docker tag reloader-backend:1.0.<N> reloaderprodacr.azurecr.io/reloader-backend:1.0.<N>
docker push reloaderprodacr.azurecr.io/reloader-backend:1.0.<N>

# 5. Actualizar Web App
az webapp config container set \
  --name reloadersystem \
  --resource-group rg-reloader-app \
  --container-image-name reloaderprodacr.azurecr.io/reloader-backend:1.0.<N>

# 6. Restart
az webapp restart --name reloadersystem --resource-group rg-reloader-app
```

Verificar: `https://reloadersystem.azurewebsites.net/health` → `OK` (esperar ~3-4 min)

---

## Datos Azure

| Recurso | Valor |
|---|---|
| ACR | `reloaderprodacr.azurecr.io` |
| Web App | `reloadersystem` |
| Resource Group | `rg-reloader-app` |
| SQL Server | `reloader-db-server.database.windows.net` |
| DB | `reloader-games-db` |
| Versión actual en producción | `1.0.22` |

---

## Secrets necesarios (GitHub Actions)

- `AZURE_CREDENTIALS`
- `ACR_USERNAME`
- `ACR_PASSWORD`
- `ACR_LOGIN_SERVER`
- `AZURE_WEBAPP_NAME`
