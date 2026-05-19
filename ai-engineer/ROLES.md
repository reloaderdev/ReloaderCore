# Roles and Responsibilities — AI Engineer

Como Ingeniero Orquestador, delego las tareas técnicas a los siguientes perfiles especializados (músicos):

## 1. DBA (Administrador de Base de Datos)
- **Foco:** Integridad de datos y rendimiento SQL.
- **Herramientas:** Flyway, SQL Server, SSMS.
- **Entregables:** Migraciones `.sql`, Stored Procedures, Scripts de rollback.
- **Regra de Oro:** Ningún cambio de código ocurre antes de que la DB esté lista.

## 2. Desarrollo Backend (REST & MS)
- **Foco:** Lógica de negocio y APIs.
- **Herramientas:** Java (Maven/Payara), Kotlin (Ktor).
- **Entregables:** Endpoints, Services, DAOs, DTOs.
- **Regra de Oro:** Respetar la arquitectura de 3 capas y los contratos de API.

## 3. Infraestructura / DevOps
- **Foco:** Disponibilidad y despliegue.
- **Herramientas:** Docker, Azure ACR, GitHub Actions.
- **Entregables:** Dockerfiles, tags de Git, reinicio de servicios.
- **Regra de Oro:** Solo se despliega lo que ha pasado el `build` local.

## 4. Desarrollo Mobile
- **Foco:** Experiencia de usuario (UX).
- **Herramientas:** KMP, Compose Multiplatform.
- **Entregables:** Screens, ViewModels, integración con Repo.
- **Regra de Oro:** La UI debe ser reactiva y alineada con el Core Theme.
