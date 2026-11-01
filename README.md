# VeilForge-CoA

Atmospheric graphics enhancements for Ascension: Conquest of Azeroth / Conquest Reborn, based on the GPL-2.0 Lumenveil renderer for the 32-bit World of Warcraft 3.3.5a client.

## Release status

- **v1.1.0** is the latest published GitHub release.
- **v1.2.0** is a local package with Level 2 as its default and a separate Windows preset selector. Its Ctrl+F7 panel does not contain the preset selector.
- **v1.3.0** is in development. This source adds an in-game ten-level preset selector to Ctrl+F7. The replacement DLL and install-ready ZIP are pending a successful Windows build and renderer harness run. Do not treat the v1.2.0 DLL as containing this feature.

## v1.3.0 preset design

The in-game selector applies ten separate profiles to 60 renderer-supported graphics settings. Level 2 - Subtle is the packaged default. Quality steps between the renderer's three supported modes; banks, liquid depth, and costly wet-surface and model-relief effects turn on in stages. Profiles preserve zone configuration, hotkeys, diagnostics, and other unmanaged settings. Light shafts, terrain shadows, and radial god rays stay off in every profile.

All existing Ctrl+F7 controls remain editable. The selector reports **Custom** when managed settings stop matching a profile. Presets and manual edits use the renderer's existing Save/Revert controls. There is no need for an external Windows selector or manual INI editing.

The profiles are individually staged from the supplied Level 1-10 configurations and checked against the renderer's live setting registry and ranges. They have not been benchmarked on the user's hardware or verified in-game; no fixed FPS result is promised.

## Build and validation

The project pins the upstream Lumenveil source revision and contains the exact renderer overlay, ten source profiles, build patch, validation script, and Windows workflow. The workflow builds the 32-bit renderer and setup utility with the Windows SDK and `fxc`, runs the upstream CPU-only harness plus preset tests, validates the DLL PE architecture, and creates a direct-extract ZIP from the existing v1.2.0 package.

The ZIP will include the rebuilt `CoAVolFog.dll`, Level 2 default INI, original DXVK files, renderer setup utility, and all license notices. The external preset selector will be removed from that package.

## Install

When a v1.3.0 release is available: close the game, back up existing graphics files and `CoAVolFog.ini`, extract the ZIP directly beside `Ascension.exe`, and run `VeilForge-Setup.cmd` for a first-time installation. Launch the game and press Ctrl+F7 to select a profile. Use **Save** to persist preset or manual changes. Existing custom settings can be retained by keeping the existing INI; the panel will show Custom if its managed values do not match a profile.

## Features

- Volumetric fog, ground mist, and weather-aware haze.
- Night lights from lamps, torches, windows, and spell effects.
- Wind-driven water, reflections, rain effects, wet surfaces, and optional relief.
- Per-zone looks and regional controls.
- Ctrl+F7 settings; Ctrl+F12 effect comparison.

The renderer reads local game data to create lamp and liquid maps. It does not modify the game executable. Compatibility or server rules may restrict graphics modifications; check applicable rules before installing.

## Credits and licenses

- VeilForge-CoA adaptation and maintenance: Uncle Bone ([uncle-bone](https://github.com/uncle-bone)).
- Renderer and original documentation: [Lumenveil contributors](https://github.com/lumenveil/Lumenveil).
- DXVK is bundled with its license notice.

Lumenveil is GPL-2.0. The exact upstream revision and VeilForge source overlays are identified in this repository and in the release package's `VeilForge-SOURCE.txt`. Preserve the bundled license and third-party notices.

[Lumenveil license](https://github.com/lumenveil/Lumenveil/blob/main/LICENSE) · [Third-party notices](https://github.com/lumenveil/Lumenveil/blob/main/THIRD-PARTY-NOTICES.md) · [Lumenveil legal notes](https://github.com/lumenveil/Lumenveil/blob/main/LEGAL.md)
