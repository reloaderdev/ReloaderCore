# Ecosystem Map — AI Engineer

Este archivo es la fuente de verdad para el **Ingeniero Orquestador**. Aquí se define el mapa de "músicos" y sus ubicaciones en el sistema.

## Músicos (Agentes) y Rutas

| Agente | Responsabilidad | Ruta Local Sugerida |
| :--- | :--- | :--- |
| **Ingeniero / Hub** | Orquestación Global | `reloaderproject-rest/` |
| **REST Agent** | Java, Maven, Payara, Azure WebApp | `reloaderproject-rest/` |
| **Microservices Agent** | Kotlin, Ktor, Docker, Auth/Supplier | `../GitHub/ReloaderCarrousel/reloaderproject-ms-/` |
| **Mobile Agent** | Kotlin Multiplatform (KMP), Compose | `../GitHub/ReloaderGames/` |
| **DBA Agent** | SQL Server, Flyway, Stored Procedures | `reloaderproject-rest/db/` |

## Estado de Conectividad
- [x] **REST/Hub:** Localizado en el workspace actual.
- [x] **Microservicios:** Localizado en ruta externa.
- [x] **Mobile:** Localizado en ruta externa.
- [x] **Base de Datos:** Localizada en subcarpeta `db/`.

## Reglas de Portabilidad
1. Al cambiar de PC, el Ingeniero debe verificar que estas rutas relativas o absolutas existan.
2. Si un músico no está presente, el Ingeniero notificará qué parte del ecosistema está "offline".
3. Toda decisión de arquitectura debe quedar registrada en `ai-engineer/decisions/`.

## Herramientas de Orquestación
- [Dashboard Turbo N8N](file:///c:/Users/resem/Documents/ProjectReloader/reloaderproject-rest/ai-engineer/DASHBOARD_N8N.html)
- [Golden Flow Orchestrator](file:///c:/Users/resem/Documents/ProjectReloader/reloaderproject-rest/ai-engineer/GOLDEN_FLOW_ORCHESTRATOR.html)
