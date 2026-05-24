# Flow: Sync Local

## Cuándo ejecutar

Cuando el usuario llega a casa después de haber hecho `git push` desde el trabajo.
Triggers: `sync local`, `levanta todo`, `bajá los cambios`.

Su función es sincronizar todos los repos del ecosistema y dejar el entorno local funcionando con los cambios más recientes.

---

## Prerequisitos

- `sql-dev` corriendo en Docker (`docker ps` debe mostrarlo en puerto 1433)
- Red Docker existente: `reloader-network`
- Maven instalado

---

## Pasos

### 1. Bajar cambios en todos los repos

```bash
git -C "C:/Users/resem/Documents/GitHub/ReloaderDB" pull origin main
git -C "C:/Users/resem/Documents/ProjectReloader/reloaderproject-rest" pull origin main
git -C "C:/Users/resem/Documents/GitHub/ReloaderCarrousel/reloaderproject-ms-" pull origin main
git -C "C:/Users/resem/Documents/GitHub/ReloaderGames" pull origin main
```

Verificar qué cambió en cada repo:

```bash
git -C "C:/Users/resem/Documents/GitHub/ReloaderDB" log --oneline -5
git -C "C:/Users/resem/Documents/ProjectReloader/reloaderproject-rest" log --oneline -5
```

### 2. Detectar migraciones nuevas

Fuente de verdad: `ReloaderDB/migrations/` — **no usar** `reloaderproject-rest/db/migrations` (solo referencia histórica).

Consultar versiones ya aplicadas en `sql-dev`:

```bash
flyway -url="jdbc:sqlserver://localhost:1433;databaseName=reloader-games-db;encrypt=false;trustServerCertificate=true" \
       -user=devlocal \
       -password=Dev@Local2026 \
       -locations=filesystem:C:/Users/resem/Documents/GitHub/ReloaderDB/migrations \
       info
```

### 3. Aplicar migraciones pendientes

```bash
flyway -url="jdbc:sqlserver://localhost:1433;databaseName=reloader-games-db;encrypt=false;trustServerCertificate=true" \
       -user=devlocal \
       -password=Dev@Local2026 \
       -locations=filesystem:C:/Users/resem/Documents/GitHub/ReloaderDB/migrations \
       migrate
```

Si no hay migraciones nuevas, Flyway no hace nada. No es un error.

### 4. Compilar el WAR

```bash
mvn -f "C:/Users/resem/Documents/ProjectReloader/reloaderproject-rest/pom.xml" clean package -q
```

Verificar:

```bash
ls "C:/Users/resem/Documents/ProjectReloader/reloaderproject-rest/target/reloaderproject.war"
```

### 5. Reconstruir la imagen Docker

```bash
docker build -t reloader-backend:local "C:/Users/resem/Documents/ProjectReloader/reloaderproject-rest/"
```

### 6. Recrear el contenedor con env vars correctas

```bash
docker stop reloader-container
docker rm reloader-container

docker run -d \
  --name reloader-container \
  --network reloader-network \
  -p 8080:8080 \
  -e DB_URL="jdbc:sqlserver://sql-dev:1433;databaseName=reloader-games-db;encrypt=false;trustServerCertificate=true;loginTimeout=30;" \
  -e DB_USER=devlocal \
  -e DB_PASSWORD="Dev@Local2026" \
  -e AUTH_SERVICE_URL="http://auth-service:8080" \
  -e SUPPLIER_SERVICE_URL="http://supplier-service:8080" \
  -e API_KEY="rl-ms-access-key" \
  reloader-backend:local
```

### 7. Sincronizar microservicios

```bash
docker-compose -f "C:/Users/resem/Documents/GitHub/ReloaderCarrousel/reloaderproject-ms-/docker-compose.yml" pull
docker-compose -f "C:/Users/resem/Documents/GitHub/ReloaderCarrousel/reloaderproject-ms-/docker-compose.yml" up -d
```

### 8. Verificar que todo levantó

```bash
docker logs reloader-container 2>&1 | grep -E "(deploy|ROOT|error|ERROR)" | tail -10
```

Esperar el mensaje: `ROOT was successfully deployed`

```bash
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
```

## Qué NO hacer

- No recrear la BD desde cero — solo aplicar migraciones pendientes con Flyway
- No usar `reloaderproject-rest/db/migrations` para migrar — es solo referencia histórica
- No usar `localhost:8081` para `AUTH_SERVICE_URL` — dentro de Docker no funciona
- No olvidar las env vars al recrear el contenedor
