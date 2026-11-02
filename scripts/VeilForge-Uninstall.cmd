@echo off
setlocal
title VeilForge-CoA uninstall
cd /d "%~dp0"

if not exist "Wow.exe" if not exist "Ascension.exe" (
  echo VeilForge-Uninstall.cmd must be in the game folder, next to Wow.exe or Ascension.exe.
  pause
  exit /b 1
)
for %%P in (Wow.exe Ascension.exe) do (
  tasklist /fi "imagename eq %%P" 2>nul | find /i "%%P" >nul
  if not errorlevel 1 (
    echo Please close %%P before uninstalling VeilForge.
    pause
    exit /b 1
  )
)

echo This removes VeilForge-CoA, its graphics settings, and generated lamp and liquid data:
echo   version.dll, CoAVolFog.dll, CoAVolFog.ini, CoAVolFog-regions.ini,
echo   lampdata.bin, liquiddata.bin, VeilForge-Setup.cmd, and the Lumenveil folder.
echo It leaves d3d9.dll, dxgi.dll, dxvk.conf, and the DXVK notice untouched because
echo those files may be shared with other graphics tools.
choice /c YN /m "Remove VeilForge-CoA"
if errorlevel 2 exit /b 0

for %%F in (version.dll CoAVolFog.dll CoAVolFog.ini CoAVolFog-regions.ini lampdata.bin liquiddata.bin CoAVolFog.log CoAVolFog-spots.txt VeilForge-Setup.cmd) do if exist "%%F" del /q "%%F"
if exist "CoAVolFog-spots" rmdir /s /q "CoAVolFog-spots"
if exist "Lumenveil" rmdir /s /q "Lumenveil"
echo VeilForge-CoA has been removed. DXVK files were left in place.
pause
(goto) 2>nul & del /q "%~f0"
