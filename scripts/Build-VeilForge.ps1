#Requires -Version 5.1
param([string]$Version = '1.3.2')
$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
$upstream = Join-Path $root 'upstream\Lumenveil'
$presetZip = Join-Path $root 'assets\VeilForge-CoA-v1.2.0-Local-Presets.zip'
$buildScript = Join-Path $upstream 'scripts\Build-Release.ps1'
$overrides = Join-Path $root 'engine-overrides'
$expectedRef = (Get-Content (Join-Path $root 'upstream-ref.txt') -Raw).Trim()

function Invoke-Native([string]$File, [string[]]$Arguments) {
    & $File @Arguments
    if ($LASTEXITCODE) { throw "$([IO.Path]::GetFileName($File)) failed (exit $LASTEXITCODE)" }
}

if (-not (Test-Path $presetZip)) { throw "Missing source package: $presetZip" }
if (-not (Test-Path $buildScript)) { throw "Missing upstream build source: $buildScript" }
$actualRef = (& git -C $upstream rev-parse HEAD).Trim()
if ($actualRef -ne $expectedRef) { throw "Unexpected Lumenveil source revision: $actualRef" }
python (Join-Path $PSScriptRoot 'Validate-VeilForge.py') --root $root --lumenveil-default (Join-Path $upstream 'engine\CoAVolFog.ini')
if ($LASTEXITCODE) { throw 'Preset source validation failed.' }

$source = Join-Path $upstream 'engine\src'
Copy-Item (Join-Path $overrides 'settings_panel.cpp') (Join-Path $source 'settings_panel.cpp') -Force
Copy-Item (Join-Path $overrides 'presets.cpp') (Join-Path $source 'presets.cpp') -Force
Copy-Item (Join-Path $overrides 'presets.h') (Join-Path $source 'presets.h') -Force
Copy-Item (Join-Path $overrides 'veilforge_presets.h') (Join-Path $source 'veilforge_presets.h') -Force
$patch = Join-Path $overrides 'build-tests.patch'
Invoke-Native 'git' @('-C', $upstream, 'apply', '--check', $patch)
Invoke-Native 'git' @('-C', $upstream, 'apply', $patch)

Push-Location $upstream
try {
    & $buildScript -Version $Version -CpuTestsOnly
    if ($LASTEXITCODE) { throw "Upstream build failed (exit $LASTEXITCODE)" }
    $harness = Join-Path $upstream 'build\engine\Release\vfog_harness.exe'
    Invoke-Native $harness @('--veilforge-profile', (Join-Path $root 'presets\Level-02.ini'))
} finally { Pop-Location }

$bin = Join-Path $upstream 'build\engine\Release'
$lamp = Join-Path $upstream 'build\lamp_extract\Release\lamp_extract.exe'
foreach ($required in @((Join-Path $bin 'CoAVolFog.dll'), (Join-Path $bin 'version.dll'), $lamp)) {
    if (-not (Test-Path $required)) { throw "Build output is missing: $required" }
}

$dist = Join-Path $root 'dist'
if (Test-Path $dist) { Remove-Item $dist -Recurse -Force }
New-Item -ItemType Directory -Path $dist | Out-Null
$stage = Join-Path $dist "VeilForge-CoA-v$Version"
New-Item -ItemType Directory -Path $stage | Out-Null
Add-Type -AssemblyName System.IO.Compression.FileSystem
[IO.Compression.ZipFile]::ExtractToDirectory($presetZip, $stage)
Copy-Item (Join-Path $bin 'CoAVolFog.dll'), (Join-Path $bin 'version.dll') $stage -Force
Copy-Item $lamp (Join-Path $stage 'Lumenveil\lamp_extract.exe') -Force
Copy-Item (Join-Path $root 'presets\Level-02.ini') (Join-Path $stage 'CoAVolFog.ini') -Force
Copy-Item (Join-Path $PSScriptRoot 'VeilForge-Setup.cmd'), (Join-Path $PSScriptRoot 'VeilForge-Uninstall.cmd') $stage -Force

foreach ($obsolete in @('VeilForge-Preset-Selector.cmd', 'VeilForge-Apply-Preset.ps1')) {
    $path = Join-Path $stage $obsolete
    if (Test-Path $path) { Remove-Item $path -Force }
}
$oldPresets = Join-Path $stage 'VeilForge-Presets'
if (Test-Path $oldPresets) { Remove-Item $oldPresets -Recurse -Force }

$readme = @"
VeilForge-CoA v$Version - IN-GAME GRAPHICS PRESETS

The Ctrl+F7 settings panel includes ten staged graphics profiles. Level 2 -
Subtle is the default in this package. Level 5 matches Lumenveil's shipped
defaults across the 60 preset controls. Levels 6-10 strengthen the effects
past that baseline; Level 10 uses maximum sampling quality. Presets change only 60
VeilForge graphics settings; zone lists, key bindings, diagnostics, and other
unrelated settings are left alone. All original advanced controls remain
available below the preset selector. A manual change displays Custom when it
does not match a profile.

INSTALL
1. Close Conquest Reborn and back up your current graphics files and INI.
2. Extract this ZIP directly into the folder containing Wow.exe or Ascension.exe.
3. Run VeilForge-Setup.cmd once for a first-time installation. It creates
   lampdata.bin and liquiddata.bin from your local game files. Existing users
   may keep their existing data files. Run setup again after game data changes.
4. Launch the game and press Ctrl+F7. Select a graphics profile in the first
   section; edit individual controls below it as desired.
5. Use Save in the panel to retain your selection and manual changes.

Level 1 is Minimal; Level 2 is Subtle (Default); Level 5 matches Lumenveil's
default controls; Levels 6-10 go beyond that baseline. Water depth is enabled
at every level. Wet surfaces, puddles, water memory, model relief, light shafts,
and terrain shadows begin at level 5; radial god rays stay off.
Higher levels may reduce FPS; actual performance depends on hardware and has
not been benchmarked on your system.

This renderer targets the 32-bit WoW 3.3.5a client. Always back up existing
files before installing or upgrading. For source and license details, see
VeilForge-SOURCE.txt and the bundled Lumenveil notices.

UNINSTALL
1. Close the game and run VeilForge-Uninstall.cmd from this folder.
2. Confirm removal. It removes VeilForge files, documentation, and generated
   data, including the Lumenveil folder. It leaves d3d9.dll, dxgi.dll,
   dxvk.conf, and the DXVK notice untouched because these may be shared with
   other graphics tools.
"@
[IO.File]::WriteAllText((Join-Path $stage 'README-FIRST.txt'), $readme, [Text.UTF8Encoding]::new($false))

$changelog = @"
VeilForge-CoA v$Version
- Match the Lumenveil default controls at Level 5 and strengthen effects through Level 10.
- Retune Levels 1-4 below baseline and Levels 6-10 above it.
- Normalize the packaged default zone-density list; enable water depth for all levels.
- Expand uninstall cleanup to remove VeilForge support files and verify removal.
- Preserve DXVK files and their notice during uninstall.
- Rebuilt the 32-bit CoAVolFog renderer with an integrated Ctrl+F7 preset selector.
- Added ten individually staged profiles; Level 2 remains the subtle package default.
- Limited preset application to the 60 profile-managed graphics settings.
- Preserved zone settings, hotkeys, diagnostics, and the renderer's advanced controls.
- Added live Custom detection and used the renderer's existing Save/Revert flow.
- Enabled light shafts and terrain shadows from the Level 5 baseline; kept radial god rays off.
- Automated CPU-only renderer checks and 32-bit PE validation; in-game behavior still needs client testing.
"@
[IO.File]::WriteAllText((Join-Path $stage 'CHANGELOG-VeilForge.txt'), $changelog, [Text.UTF8Encoding]::new($false))
$sourceNote = @"
Corresponding source for VeilForge-CoA v$Version

Lumenveil source revision: $expectedRef
Upstream: https://github.com/lumenveil/Lumenveil/tree/$expectedRef
VeilForge source and renderer overlays: https://github.com/uncle-bone/VeilForge-CoA

The repository contains the exact renderer overlay files, preset profiles,
build patch, validation checks, and the Windows build workflow used for this
release. Lumenveil is GPL-2.0; retain the bundled license and third-party notices.
"@
[IO.File]::WriteAllText((Join-Path $stage 'VeilForge-SOURCE.txt'), $sourceNote, [Text.UTF8Encoding]::new($false))

function Assert-X86Dll([string]$path) {
    $bytes = [IO.File]::ReadAllBytes($path)
    if ($bytes.Length -lt 256 -or $bytes[0] -ne 0x4D -or $bytes[1] -ne 0x5A) { throw "Invalid PE DOS header: $path" }
    $pe = [BitConverter]::ToInt32($bytes, 0x3C)
    if ($pe -lt 0 -or $pe + 26 -gt $bytes.Length -or [BitConverter]::ToUInt32($bytes, $pe) -ne 0x00004550) {
        throw "Invalid PE header: $path"
    }
    if ([BitConverter]::ToUInt16($bytes, $pe + 4) -ne 0x014C -or [BitConverter]::ToUInt16($bytes, $pe + 24) -ne 0x010B) {
        throw "Expected a 32-bit x86 DLL: $path"
    }
}
Assert-X86Dll (Join-Path $stage 'CoAVolFog.dll')
Assert-X86Dll (Join-Path $stage 'version.dll')
Get-ChildItem $stage -Filter '*.dll' -File -Recurse | ForEach-Object { Assert-X86Dll $_.FullName }

$zip = Join-Path $dist "VeilForge-CoA-v$Version.zip"
[IO.Compression.ZipFile]::CreateFromDirectory($stage, $zip, [IO.Compression.CompressionLevel]::Optimal, $false)
$archive = [IO.Compression.ZipFile]::OpenRead($zip)
try {
    $entries = @($archive.Entries | ForEach-Object FullName)
    foreach ($entry in @('CoAVolFog.dll', 'CoAVolFog.ini', 'version.dll', 'd3d9.dll', 'dxgi.dll', 'VeilForge-Setup.cmd', 'VeilForge-Uninstall.cmd', 'VeilForge-SOURCE.txt')) {
        if ($entries -notcontains $entry) { throw "Install archive is missing $entry" }
    }
    foreach ($scriptName in @('VeilForge-Setup.cmd', 'VeilForge-Uninstall.cmd')) {
        $scriptText = [IO.File]::ReadAllText((Join-Path $stage $scriptName))
        foreach ($exeName in @('Wow.exe', 'Ascension.exe')) {
            if (-not $scriptText.Contains($exeName)) { throw "$scriptName does not support $exeName" }
        }
    }
    $uninstallText = [IO.File]::ReadAllText((Join-Path $stage 'VeilForge-Uninstall.cmd'))
    foreach ($ownedFile in @('version.dll', 'CoAVolFog.dll', 'CoAVolFog.ini', 'CoAVolFog-regions.ini', 'lampdata.bin', 'liquiddata.bin', 'CoAVolFog-spots', 'Lumenveil', 'VeilForge-Presets', 'README-FIRST', 'CHANGELOG-VeilForge', 'BUILD', 'VeilForge-Original-v1.1.0.ini', 'VeilForge-SOURCE', 'Dear-ImGui-LICENSE')) {
        if (-not $uninstallText.Contains($ownedFile)) { throw "Uninstaller does not remove VeilForge file or folder $ownedFile" }
    }
    foreach ($sharedFile in @('d3d9.dll', 'dxgi.dll', 'dxvk.conf', 'DXVK')) {
        if (-not $uninstallText.Contains($sharedFile)) { throw "Uninstaller does not document preserving shared DXVK file $sharedFile" }
    }
    if ($entries -match '^(VeilForge-Preset-Selector\.cmd|VeilForge-Apply-Preset\.ps1|VeilForge-Presets/)') {
        throw 'Obsolete external preset selection files remain in the install archive.'
    }
} finally { $archive.Dispose() }
$sum = (Get-FileHash $zip -Algorithm SHA256).Hash.ToLowerInvariant()
[IO.File]::WriteAllText((Join-Path $dist 'SHA256SUMS.txt'), "$sum  VeilForge-CoA-v$Version.zip`r`n", [Text.UTF8Encoding]::new($false))
Write-Host "Built and validated $zip"
Write-Host "SHA256 $sum"
