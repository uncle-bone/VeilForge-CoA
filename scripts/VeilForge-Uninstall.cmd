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
echo   lampdata.bin, liquiddata.bin, VeilForge support files, and the Lumenveil folder.
echo It leaves d3d9.dll, dxgi.dll, dxvk.conf, and the DXVK notice untouched because
echo those files may be shared with other graphics tools.
choice /c YN /m "Remove VeilForge-CoA"
if errorlevel 2 exit /b 0

for %%F in (version.dll CoAVolFog.dll CoAVolFog.ini CoAVolFog-regions.ini lampdata.bin liquiddata.bin CoAVolFog.log CoAVolFog-spots.txt VeilForge-Setup.cmd README-FIRST README-FIRST.txt CHANGELOG-VeilForge CHANGELOG-VeilForge.txt VeilForge-Original-v1.1.0.ini VeilForge-SOURCE VeilForge-SOURCE.txt BUILD BUILD.txt Dear-ImGui-LICENSE Dear-ImGui-LICENSE.txt) do if exist "%%F" del /q "%%F"
if exist "CoAVolFog-spots" rmdir /s /q "CoAVolFog-spots"
if exist "Lumenveil" rmdir /s /q "Lumenveil"
for %%F in (VeilForge-Preset-Selector.cmd VeilForge-Apply-Preset.ps1) do if exist "%%F" del /q "%%F"
if exist "VeilForge-Presets" rmdir /s /q "VeilForge-Presets"
for %%F in (version.dll CoAVolFog.dll CoAVolFog.ini CoAVolFog-regions.ini lampdata.bin liquiddata.bin CoAVolFog.log CoAVolFog-spots.txt VeilForge-Setup.cmd README-FIRST README-FIRST.txt CHANGELOG-VeilForge CHANGELOG-VeilForge.txt VeilForge-Original-v1.1.0.ini VeilForge-SOURCE VeilForge-SOURCE.txt BUILD BUILD.txt Dear-ImGui-LICENSE Dear-ImGui-LICENSE.txt VeilForge-Preset-Selector.cmd VeilForge-Apply-Preset.ps1) do if exist "%%F" goto :cleanup_failed
if exist "CoAVolFog-spots" goto :cleanup_failed
if exist "Lumenveil" goto :cleanup_failed
if exist "VeilForge-Presets" goto :cleanup_failed
echo VeilForge-CoA has been removed. DXVK files were left in place.
pause
(goto) 2>nul & del /q "%~f0"
exit /b 0

:cleanup_failed
echo Some VeilForge files could not be removed. Close the game and check file permissions, then run the uninstaller again.
pause
exit /b 1
