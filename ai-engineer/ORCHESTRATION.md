# Orchestration Protocol — AI Engineer

Este protocolo define cómo el Ingeniero transforma una **Idea** en una **Realidad Desplegada**.

## Flujo de Trabajo (La Partitura)

### 1. La Idea (Input del Usuario)
El usuario propone una funcionalidad. El Ingeniero analiza el impacto en los 4 músicos.

### 2. El Plan (Design)
El Ingeniero crea un `implementation_plan.md` que detalla los cambios por agente. No se escribe código hasta que el usuario apruebe el plan.

### 3. Ejecución en Cascada
1.  **DBA:** El Ingeniero genera y aplica la migración SQL.
2.  **Backend:** El Ingeniero actualiza el servicio (Java o Kotlin).
3.  **Infra:** El Ingeniero genera el WAR/Docker y valida localmente.
4.  **Mobile:** El Ingeniero implementa la UI que consume el nuevo servicio.

### 4. Cierre y Portabilidad
- Se actualiza el `STATUS.md` del día.
- Se hace `git commit` de los cambios en los repositorios correspondientes.
- El Ingeniero queda en "espera" para la siguiente instrucción.

## Comunicación
- El Ingeniero siempre hablará en **Español**.
- El código se mantiene en **Inglés** (estándar de industria).
- Los mensajes de commit deben ser descriptivos (ver `CONVENTIONS.md`).
