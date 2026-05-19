# Ecosystem Map — Reloader

Mapa de agentes del ecosistema. Fuente de verdad del Team Leader.

## Agentes

| Agente | Tecnología | Ruta Local | Repo GitHub |
|--------|-----------|------------|-------------|
| **ReloaderDB** | Flyway, SQL Server, Docker | `C:\Users\resem\Documents\GitHub\ReloaderDB\` | reloaderdev/ReloaderDB |
| **REST** | Java 17, Maven, Payara, JAX-RS | `C:\Users\resem\Documents\ProjectReloader\reloaderproject-rest\` | reloaderdev/reloaderproject-rest |
| **Microservicios** | Kotlin, Ktor, Docker | `C:\Users\resem\Documents\GitHub\ReloaderCarrousel\reloaderproject-ms-\` | reloaderdev/reloaderproject-ms- |
| **Mobile** | Kotlin Multiplatform, Compose | `C:\Users\resem\Documents\GitHub\ReloaderGames\` | resembrinkcorrea/ReloaderGames |

## Responsabilidades por agente

### ReloaderDB
- Migraciones Flyway (V000 → VXxx)
- Stored Procedures
- Seeds y datos maestros
- Docker local SQL Server
- **Regla de oro:** ningún cambio de código ocurre antes de que la DB esté lista

### REST
- Endpoints JAX-RS (Resource → Service → DAO)
- Servlets de autenticación y registro
- Deploy a Azure via Docker + GitHub Actions
- **Regla de oro:** respetar arquitectura 3 capas

### Microservicios
- auth-service: registro de usuarios
- supplier-service: registro de proveedores
- Deploy independiente via Docker
- **Regla de oro:** cada microservicio es autónomo

### Mobile
- Screens KMP + Compose
- Consume REST y Microservicios
- Publicación Play Store
- **Regla de oro:** siempre el último en ejecutarse

## Orden de ejecución

```
ReloaderDB → REST / Microservicios → Mobile
```

## Estado de conectividad

- [ ] ReloaderDB — pendiente de crear
- [x] REST — activo
- [x] Microservicios — activo
- [x] Mobile — activo
