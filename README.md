# VeilForge-CoA

[![Download VeilForge-CoA v1.3.2](https://img.shields.io/badge/Download-VeilForge--CoA%20v1.3.2-brightgreen?style=for-the-badge)](https://github.com/uncle-bone/VeilForge-CoA/releases/latest/download/VeilForge-CoA-v1.3.2.zip)

Atmospheric graphics enhancements for Ascension: Conquest of Azeroth / Conquest Reborn. VeilForge-CoA is based on the GPL-2.0 Lumenveil renderer for the 32-bit World of Warcraft 3.3.5a client.

## Release status

- **v1.3.2** is the current stable release. Level 5 matches Lumenveil's default values across the 60 preset controls; Levels 1–4 are gentler, and Levels 6–10 go beyond the baseline. Water depth is enabled at every level. The packaged default no longer starts with fog reduced by per-zone multipliers. The uninstaller removes VeilForge support files and Lumenveil while preserving DXVK. Download it from the [GitHub Releases page](https://github.com/uncle-bone/VeilForge-CoA/releases/latest). In-game behavior and hardware-specific performance still need player testing.
- **v1.3.1** added setup and uninstall support for folders containing either `Wow.exe` or `Ascension.exe`.
- **v1.3.0** added the in-game preset selector. **v1.2.0** was the previous local package and used a separate Windows preset selector.

## v1.3.2 graphics presets

The Ctrl+F7 panel includes ten staged profiles covering 60 renderer settings. **Level 2 — Subtle** is the packaged default. **Level 5** matches Lumenveil's shipped defaults across those 60 controls; Levels 1–4 reduce effects below that baseline, while Levels 6–10 strengthen them beyond it. Level 10 uses maximum sampling quality. Wet-surface, model-relief, light-shaft, and terrain-shadow effects begin at Level 5; radial god rays remain off. Water depth data is active at every level.

Presets only change their managed graphics settings and preserve zone configuration, hotkeys, diagnostics, and other unrelated settings. All advanced controls remain editable. If you change managed settings so they no longer match a profile, the selector shows **Custom**. Use **Save** in Ctrl+F7 to keep a preset or your manual changes.

## Upgrade instructions

Already have VeilForge-CoA installed? **You do not need to uninstall the previous version.**

1. Completely close Conquest Reborn.
2. Download the latest VeilForge-CoA ZIP from the [GitHub Releases page](https://github.com/uncle-bone/VeilForge-CoA/releases/latest).
3. Open your Conquest Reborn installation folder, where `Wow.exe` or `Ascension.exe` is located.
4. Extract the ZIP directly into that folder.
5. Choose **Replace all existing files** when prompted. Back up your existing `CoAVolFog.ini` first if you want to keep a copy of your custom settings.
6. Run `VeilForge-Setup.cmd` to refresh the generated lamp and liquid data. This is recommended when upgrading and required for a new installation. It supports game folders containing either `Wow.exe` or `Ascension.exe`.
7. Launch Conquest Reborn and press **Ctrl+F7** to choose one of the ten graphics levels.
8. Press **Save** in the panel to persist your selection.

### Recommended starting point: Level 2 — Subtle

Level 2 provides restrained visual improvements while keeping performance in mind. Higher levels enable additional effects in stages; choose a level based on your system and preference.

**Additional notes**

- Continue using the Ctrl+F7 panel for advanced graphics settings and preset selection.
- The old `VeilForge-Preset-Selector.cmd` is not used in v1.3.0; select levels in-game with Ctrl+F7.
- Existing custom settings can be kept by preserving your old `CoAVolFog.ini`. If its settings do not match a preset, the panel will show **Custom**.
- New installations should run `VeilForge-Setup.cmd` once before launching the game.

### Uninstall

Close the game and run `VeilForge-Uninstall.cmd` from the game folder. Confirm removal when prompted. The uninstaller removes VeilForge DLLs, settings, generated lamp/liquid data, documentation, and the `Lumenveil` folder. It supports folders containing either `Wow.exe` or `Ascension.exe` and reports if any core VeilForge files remain. It leaves `d3d9.dll`, `dxgi.dll`, `dxvk.conf`, and the DXVK notice in place because those files may be shared with other graphics tools.

**That’s it: Extract → Replace → Run Setup → Select a level in Ctrl+F7 → Save → Play!**

## Build and validation

The project pins the upstream Lumenveil source revision and includes the renderer overlay, ten profile files, validation scripts, and a Windows build workflow. The workflow builds the 32-bit renderer and setup utility, runs the upstream CPU-only harness and preset checks, validates the DLL architecture, and packages a direct-extract ZIP from the supplied v1.2.0 package.

The ZIP includes the rebuilt `CoAVolFog.dll`, the Level 2 default INI, original DXVK files, setup utility, and license notices. It does not include the old external preset selector.

The profiles have not been benchmarked on the user's hardware or verified in-game; no fixed FPS result is promised.

## Features

- Volumetric fog, ground mist, and weather-aware haze.
- Night lights from lamps, torches, windows, and spell effects.
- Wind-driven water, reflections, rain effects, wet surfaces, and optional relief.
- Per-zone looks and regional controls.
- Ctrl+F7 settings and presets; Ctrl+F12 effect comparison.

The renderer reads local game data to create lamp and liquid maps. It does not modify the game executable. Compatibility or server rules may restrict graphics modifications; check applicable rules before installing.

## Credits and licenses

- VeilForge-CoA adaptation and maintenance: Uncle Bone ([uncle-bone](https://github.com/uncle-bone)).
- Renderer and original documentation: [Lumenveil contributors](https://github.com/lumenveil/Lumenveil).
- DXVK is bundled with its license notice.

Lumenveil is GPL-2.0. The exact upstream revision and VeilForge source overlays are identified in this repository and in the release package's `VeilForge-SOURCE.txt`. Preserve the bundled license and third-party notices.

[Lumenveil license](https://github.com/lumenveil/Lumenveil/blob/main/LICENSE) · [Third-party notices](https://github.com/lumenveil/Lumenveil/blob/main/THIRD-PARTY-NOTICES.md) · [Lumenveil legal notes](https://github.com/lumenveil/Lumenveil/blob/main/LEGAL.md)
