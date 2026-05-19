# MISSION: CLEANUP SELLER REGISTRATION
# AGENT: AI ORCHESTRATOR

$StatusPath = "C:\Users\resem\Documents\ProjectReloader\reloaderproject-rest\ai-engineer\data.js"
$BrowserStatusPath = "C:\Users\resem\.gemini\antigravity\brain\c2df8e52-8fac-4e39-82bf-097a5833bb1f\browser\data.js"

function Update-Dashboard($NodeA, $NodeB, $NodeC, $NodeD, $Text, $Success) {
    $Line1 = 'var dashboardData = {'
    $Line2 = '  "mission": "Limpieza Vendedor (SCRIPT AUTONOMO)",'
    $Line3 = '  "statusText": "' + $Text + '",'
    $Line4 = '  "nodes": { "A": "' + $NodeA + '", "B": "' + $NodeB + '", "C": "' + $NodeC + '", "D": "' + $NodeD + '" },'
    $Line5 = '  "success": ' + $Success
    $Line6 = '};'
    $FullContent = $Line1, $Line2, $Line3, $Line4, $Line5, $Line6
    $FullContent | Set-Content $StatusPath
    Copy-Item $StatusPath $BrowserStatusPath -Force
}

# --- FASE 1: BUSCAR Y ELIMINAR UI ---
Update-Dashboard "active" "pending" "pending" "pending" "Eliminando bloque UI en LoginScreen.kt..." "false"
$LoginPath = "C:\Users\resem\Documents\GitHub\ReloaderGames\composeApp\src\commonMain\kotlin\dev\reloader\games\presentation\screens\login\LoginScreen.kt"
if (Test-Path $LoginPath) {
    $content = Get-Content $LoginPath -Raw
    $content = $content -replace '(?s)\s+Text\(.*?register-seller".*?\)', ''
    $content | Set-Content $LoginPath
}

# --- FASE 2: LIMPIAR NAVEGACIÓN ---
Update-Dashboard "done" "active" "pending" "pending" "Limpiando Navigator.kt y rutas..." "false"
$NavPath = "C:\Users\resem\Documents\GitHub\ReloaderGames\composeApp\src\commonMain\kotlin\dev\reloader\games\presentation\navigation\Navigator.kt"
if (Test-Path $NavPath) {
    $content = Get-Content $NavPath -Raw
    $content = $content -replace 'import.*?registerseller.*?\r?\n', ''
    $content = $content -replace '(?s)\s+composable\("/register-seller"\).*?\}', ''
    $content | Set-Content $NavPath
}

# --- FASE 3: BORRAR ARCHIVOS Y CARPETAS ---
Update-Dashboard "done" "done" "active" "pending" "Borrando carpeta fisica de RegisterSeller..." "false"
$FolderPath = "C:\Users\resem\Documents\GitHub\ReloaderGames\composeApp\src\commonMain\kotlin\dev\reloader\games\presentation\screens\registerseller"
if (Test-Path $FolderPath) {
    Remove-Item -Path $FolderPath -Recurse -Force -ErrorAction SilentlyContinue
}

# --- FASE 4: LIMPIEZA DE REPOSITORIO ---
Update-Dashboard "done" "done" "done" "active" "Limpiando contratos en Repository y RepoImpl..." "false"
$RepoContract = "C:\Users\resem\Documents\GitHub\ReloaderGames\composeApp\src\commonMain\kotlin\dev\reloader\games\domain\repository\Repository.kt"
$RepoImpl = "C:\Users\resem\Documents\GitHub\ReloaderGames\composeApp\src\commonMain\kotlin\dev\reloader\games\data\repository\RepoImpl.kt"

if (Test-Path $RepoContract) {
    $content = Get-Content $RepoContract -Raw
    $content = $content -replace 'suspend fun registerSeller.*', ''
    $content | Set-Content $RepoContract
}
if (Test-Path $RepoImpl) {
    $content = Get-Content $RepoImpl -Raw
    $content = $content -replace '(?s)\s+override suspend fun registerSeller.*?\}', ''
    $content | Set-Content $RepoImpl
}

# --- FIN ---
Update-Dashboard "done" "done" "done" "done" "MISIÓN COMPLETADA CON EXITO!" "true"
Write-Host "Mission Accomplished."
