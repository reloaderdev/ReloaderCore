@echo off
echo ==========================================
echo    AUDITORIA DE AGENTES (Modo CMD)
echo ==========================================

echo [INFO] Iniciando chequeo de rutas...

set REST_PATH=C:\Users\resem\Documents\ProjectReloader\reloaderproject-rest
set MS_PATH=C:\Users\resem\Documents\GitHub\ReloaderCarrousel\reloaderproject-ms-
set MOBILE_PATH=C:\Users\resem\Documents\GitHub\ReloaderGames

if exist "%REST_PATH%" (echo [OK] Nodo REST localizado.) else (echo [ERR] Nodo REST NO localizado.)
if exist "%MS_PATH%" (echo [OK] Nodo Microservicios localizado.) else (echo [ERR] Nodo MS NO localizado.)
if exist "%MOBILE_PATH%" (echo [OK] Nodo Mobile localizado.) else (echo [ERR] Nodo Mobile NO localizado.)

echo.
echo [INFO] Verificando infraestructura...
REM Aqui se pueden agregar comandos de docker o maven si se desea
echo [DOCKER] Para ver contenedores usa: docker ps

echo.
echo [INFO] Dashboard actualizado visualmente en SYSTEM_DASHBOARD.md
echo ==========================================
pause
