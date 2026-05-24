# Flow: Reloader Docker

## Cuándo ejecutar

Cuando el usuario escribe `reloader docker`.

Levantar todo el ecosistema local desde cero, en el orden correcto.
El líder ejecuta cada paso directamente via Bash. Si un paso falla, reporta y espera instrucción.

---

## Orden de ejecución

```
ReloaderDB (sql-dev) → Flyway migrate → REST (reloader-container) → Microservicios
```

---

## Pasos

### 1. Levantar la base de datos

```bash
docker start sql-dev
```

Verificar que responde:

```bash
docker exec sql-dev /opt/mssql-tools18/bin/sqlcmd -S localhost -U devlocal -P "Dev@Local2026" -Q "SELECT 'DB OK'" -No -C
```

### 2. Aplicar migraciones pendientes

Fuente de verdad: `ReloaderDB/migrations/` — no usar `reloaderproject-rest/db/migrations` (solo referencia histórica).

```bash
flyway -url="jdbc:sqlserver://localhost:1433;databaseName=reloader-games-db;encrypt=false;trustServerCertificate=true" \
       -user=devlocal \
       -password=Dev@Local2026 \
       -locations=filesystem:C:/Users/resem/Documents/GitHub/ReloaderDB/migrations \
       migrate
```

Si no hay migraciones nuevas, Flyway pasa sin hacer nada. No es un error.

### 3. Compilar el WAR

```bash
mvn -f "C:/Users/resem/Documents/ProjectReloader/reloaderproject-rest/pom.xml" clean package -q
```

Verificar que se generó:

```
target/reloaderproject.war
```

### 4. Reconstruir y recrear reloader-container

```bash
docker build -t reloader-backend:local "C:/Users/resem/Documents/ProjectReloader/reloaderproject-rest/"

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

### 5. Levantar microservicios

```bash
docker-compose -f "C:/Users/resem/Documents/GitHub/ReloaderCarrousel/reloaderproject-ms-/docker-compose.yml" up -d
```

### 6. Verificar health de los 4 servicios

| Servicio | URL | Esperado |
|---|---|---|
| reloader-container | http://localhost:8080/health | 200 OK |
| auth-service | http://localhost:8081/health | 200 OK |
| supplier-service | http://localhost:8082/health | 200 OK |
| sql-dev | puerto 1433 | DB OK |

```bash
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
```

## Resultado esperado

```
NAMES                STATUS       PORTS
reloader-container   Up X seconds 0.0.0.0:8080->8080/tcp
auth-service         Up X seconds 0.0.0.0:8081->8080/tcp
supplier-service     Up X seconds 0.0.0.0:8082->8080/tcp
sql-dev              Up X minutes 0.0.0.0:1433->1433/tcp
```

App disponible en: `http://localhost:8080/login.jsp`

## Notas

- El WAR siempre se reconstruye — garantiza que el código que corre es el actual
- Los microservicios se manejan con compose — tienen sus propias env vars en docker-compose.yml
- sql-dev y reloader-container se manejan por separado — no tienen compose
- Si sql-dev ya estaba corriendo, `docker start` no hace nada — no es un error
