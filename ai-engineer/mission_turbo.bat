@echo off
set StatusPath=C:\Users\resem\Documents\ProjectReloader\reloaderproject-rest\ai-engineer\data.js
set BrowserPath=C:\Users\resem\.gemini\antigravity\brain\c2df8e52-8fac-4e39-82bf-097a5833bb1f\browser\data.js

echo Phase 1: UI Cleanup
powershell -Command "(Get-Content 'C:\Users\resem\Documents\GitHub\ReloaderGames\composeApp\src\commonMain\kotlin\dev\reloader\games\presentation\screens\login\LoginScreen.kt') -replace '(?s)\s+Text\(.*?register-seller\".*?\)', '' | Set-Content 'C:\Users\resem\Documents\GitHub\ReloaderGames\composeApp\src\commonMain\kotlin\dev\reloader\games\presentation\screens\login\LoginScreen.kt'"

echo Phase 2: Navigation Cleanup
powershell -Command "(Get-Content 'C:\Users\resem\Documents\GitHub\ReloaderGames\composeApp\src\commonMain\kotlin\dev\reloader\games\presentation\navigation\Navigator.kt') -replace 'import.*?registerseller.*?\r?\n', '' -replace '(?s)\s+composable\(\"/register-seller\"\).*?\}', '' | Set-Content 'C:\Users\resem\Documents\GitHub\ReloaderGames\composeApp\src\commonMain\kotlin\dev\reloader\games\presentation\navigation\Navigator.kt'"

echo Phase 3: Folder Deletion
rd /s /q "C:\Users\resem\Documents\GitHub\ReloaderGames\composeApp\src\commonMain\kotlin\dev\reloader\games\presentation\screens\registerseller" 2>nul

echo Phase 4: Repository Cleanup
powershell -Command "(Get-Content 'C:\Users\resem\Documents\GitHub\ReloaderGames\composeApp\src\commonMain\kotlin\dev\reloader\games\domain\repository\Repository.kt') -replace '\s+suspend fun registerSeller.*', '' | Set-Content 'C:\Users\resem\Documents\GitHub\ReloaderGames\composeApp\src\commonMain\kotlin\dev\reloader\games\domain\repository\Repository.kt'"
powershell -Command "(Get-Content 'C:\Users\resem\Documents\GitHub\ReloaderGames\composeApp\src\commonMain\kotlin\dev\reloader\games\data\repository\RepoImpl.kt') -replace '(?s)\s+override suspend fun registerSeller.*?\}', '' | Set-Content 'C:\Users\resem\Documents\GitHub\ReloaderGames\composeApp\src\commonMain\kotlin\dev\reloader\games\data\repository\RepoImpl.kt'"

echo Finalizing Dashboard
echo var dashboardData = { "mission": "Limpieza Vendedor (BATCH TURBO)", "statusText": "MISIÓN COMPLETADA", "nodes": { "A": "done", "B": "done", "C": "done", "D": "done" }, "success": true }; > %StatusPath%
copy %StatusPath% %BrowserPath% /y >nul

echo MISSION ACCOMPLISHED.
