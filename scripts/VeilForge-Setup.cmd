@echo off
setlocal
title VeilForge-CoA setup
cd /d "%~dp0"

if not exist "Wow.exe" if not exist "Ascension.exe" (
  echo VeilForge-Setup.cmd must be in the game folder, next to Wow.exe or Ascension.exe.
  pause
  exit /b 1
)
for %%P in (Wow.exe Ascension.exe) do (
  tasklist /fi "imagename eq %%P" 2>nul | find /i "%%P" >nul
  if not errorlevel 1 (
    echo Please close %%P before running setup.
    pause
    exit /b 1
  )
)
if not exist "Lumenveil\lamp_extract.exe" (
  echo The Lumenveil folder is missing. Extract all VeilForge files into the game folder and run setup again.
  pause
  exit /b 1
)

set "LOCALE="
for /d %%L in ("Data\????") do if exist "%%L\locale-%%~nxL.MPQ" set "LOCALE=%%~nxL"
if not defined LOCALE (
  echo No language folder with a locale archive was found in Data.
  echo VeilForge needs the 3.3.5a client, build 12340.
  pause
  exit /b 1
)

echo VeilForge reads your local game files to find world lamps and water.
echo This takes one to five minutes. It does not change game files or send data.
echo Language: %LOCALE%
echo.

echo [1/2] Lamps, torches, braziers and windows...
"Lumenveil\lamp_extract.exe" --data "%~dp0Data" --out "%~dp0lampdata.bin" --locale %LOCALE% --background > "Lumenveil\setup-lamps.log" 2>&1
if errorlevel 1 (
  echo Failed. Details are in Lumenveil\setup-lamps.log.
  pause
  exit /b 1
)

echo [2/2] Lakes and the sea...
"Lumenveil\lamp_extract.exe" --data "%~dp0Data" --liquids "%~dp0liquiddata.bin" --maps 0,1,530,571 --locale %LOCALE% --background > "Lumenveil\setup-water.log" 2>&1
if errorlevel 1 (
  echo Failed. Details are in Lumenveil\setup-water.log.
  pause
  exit /b 1
)

echo.
echo Done. Start the game as usual; if it is running, restart it.
echo   Ctrl+F12  switches VeilForge off and on
echo   Ctrl+F7   opens the settings and graphics preset panel
pause
