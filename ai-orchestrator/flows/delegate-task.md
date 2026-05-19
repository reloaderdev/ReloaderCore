# Flow: Delegar Tarea

Protocolo que sigue el Team Leader para delegar trabajo a un agente.

## Pasos

### 1. Identificar agentes afectados
Leer ECOSYSTEM.md y determinar qué agentes necesitan actuar.
Criterios:
- ¿Hay cambio de schema o SP? → ReloaderDB obligatorio
- ¿Hay nuevo endpoint o lógica de negocio? → REST y/o Microservicios
- ¿Hay nueva pantalla o flujo de usuario? → Mobile

### 2. Crear implementation_plan.md
Formato:

```
# Plan: [nombre de la funcionalidad]

## Agentes afectados
- ReloaderDB: [qué debe hacer]
- REST: [qué debe hacer]
- Mobile: [qué debe hacer]

## Pasos en orden
1. [Agente] → [tarea concreta] → [entregable esperado]
2. ...

## Dependencias
- Paso 2 depende del output del Paso 1: [qué necesita exactamente]
```

### 3. Esperar aprobación del usuario
No delegar hasta que el usuario confirme el plan.

### 4. Delegar al primer agente
Incluir en la delegación:
- Tarea específica
- Contexto relevante (qué cambió antes, contratos a respetar)
- Entregable esperado (qué debe producir)

### 5. Recibir y validar output
Verificar que el entregable:
- Existe y está completo
- Es coherente con lo que necesita el siguiente agente
- No rompe convenciones del ecosistema

### 6. Pasar contexto al siguiente agente
Incluir el output del agente anterior como contexto de entrada.

### 7. Repetir hasta completar todos los pasos

### 8. Reportar al usuario
Resumen de qué hizo cada agente y qué fue entregado.
