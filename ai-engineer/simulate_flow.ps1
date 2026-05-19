# Simulación del Golden Flow para el Dashboard
$statusFile = "c:\Users\resem\Documents\ProjectReloader\reloaderproject-rest\ai-engineer\golden_flow_status.json"

function Update-Status($json) {
    $json | ConvertTo-Json -Depth 10 | Out-File $statusFile -Encoding utf8
    Write-Host "Dashboard Actualizado..." -ForegroundColor Cyan
    Start-Sleep -Seconds 3
}

# 1. DBA Iniciando
$data = Get-Content $statusFile | ConvertFrom-Json
$data.dba.status = "active"
$data.dba.details = "Generando scripts SQL para la columna 'socios'..."
$data.overall_progress = 10
Update-Status $data

# 2. DBA Finalizado
$data.dba.status = "done"
$data.dba.details = "Scripts y SP creados exitosamente."
$data.overall_progress = 30
Update-Status $data

# 3. Decision Hub
$data.decision_hub.choice = "Ktor (Microservicios)"
$data.backend.status = "active"
$data.backend.type = "Kotlin / Ktor"
$data.backend.details = "Desarrollando endpoints de socios..."
$data.overall_progress = 50
Update-Status $data

# 4. Backend Finalizado
$data.backend.status = "done"
$data.backend.details = "Endpoints /api/partners desplegados."
$data.overall_progress = 75
Update-Status $data

# 5. Mobile Iniciando
$data.mobile.status = "active"
$data.mobile.details = "Implementando interfaz de Socios en KMP..."
$data.overall_progress = 90
Update-Status $data

# 6. Todo Listo
$data.mobile.status = "done"
$data.mobile.details = "Interfaz terminada y conectada."
$data.overall_progress = 100
Update-Status $data

Write-Host "Misión Cumplida: Golden Flow Completado." -ForegroundColor Green
