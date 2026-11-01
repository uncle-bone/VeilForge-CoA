# VeilForge-CoA

**Atmospheric graphics enhancements for Ascension: Conquest of Azeroth — Conquest Reborn.**

[**Download VeilForge-CoA v1.1.0 — Visual Refinement**](https://github.com/uncle-bone/VeilForge-CoA/releases/download/v1.1.0/VeilForge-CoA-v1.1.0.zip) · [Release notes](https://github.com/uncle-bone/VeilForge-CoA/releases/tag/v1.1.0)

VeilForge-CoA is an independent Conquest Reborn adaptation of the open-source [Lumenveil](https://github.com/lumenveil/Lumenveil) graphics mod for the World of Warcraft 3.3.5a client. It packages DXVK, the CoAVolFog/Lumenveil renderer, and a helper that generates lamp and liquid data from the player's own game installation.

> **Release status: v1.1.0 remains the latest published GitHub Release. A separate **v1.2.0 local preset build** has been assembled but is **not published as a GitHub Release**. Sun/moon shafts and terrain shadows are OFF by default to avoid artifact-prone effects; fog and water defaults are conservative. The package includes the setup script, DXVK, and upstream notices. Windows installation and in-game compatibility have not been independently tested. Back up existing graphics files before extracting.

> **In-game preset status:** The requested 1–10 selector **inside Ctrl+F7 is not implemented** in the v1.2.0 local package. The included preset selector is external and does not satisfy the intended in-game feature. Do **not** describe v1.2.0 as a finished in-game preset release or stable upgrade. The Ctrl+F7 UI requires a rebuilt CoAVolFog renderer. Level 2 is currently a configuration default, not an in-game UI selection.

## v1.2.0 local build — graphics presets (not yet on GitHub Releases)

The locally packaged **v1.2.0** build introduces **10 graphics preset levels**, with **Level 2/10** installed as the subtle, first-run default rather than the earlier midrange starter configuration.

- **Levels 1–2:** minimal to subtle enhancement, with Level 2 as the default.
- **Levels 3–5:** progressively enhanced visuals.
- **Level 6:** intended Golden Standard profile.
- **Levels 7–10:** increasingly demanding visual options; higher levels may reduce FPS.
- **60+ managed configuration settings** are adjusted through preset snapshots, while custom settings, region lists, keybindings and other unmanaged values are preserved.
- **`VeilForge-Preset-Selector.cmd`** is a Windows-based 1–10 preset selector. It updates `CoAVolFog.ini` while keeping a backup of the initial configuration for restoration.
- **The Ctrl+F7 panel is unchanged.** It is compiled into `CoAVolFog.dll`; **there is no in-game 1–10 slider** in this build. Ctrl+F7 still opens the original advanced renderer controls.
- Artifact-prone **LightShafts, TerrainShadows and GodRays remain disabled at every level**.

### Installing or upgrading to the v1.2.0 local build

Already using VeilForge-CoA? **No uninstall is necessary.**

1. Completely close Conquest Reborn.
2. Get the **v1.2.0 local ZIP** (this version is not yet available on GitHub Releases).
3. Open the Conquest Reborn game folder containing `Ascension.exe`.
4. Extract the ZIP **directly into that folder** (not into a nested folder), choosing **Replace existing files** when prompted.
5. Run `VeilForge-Setup.cmd` to regenerate lamp and liquid data from your local game installation. For existing installations, rerunning setup is optional; it is included here as a refresh step. Wait for it to finish.
6. Run `VeilForge-Preset-Selector.cmd` and select a graphics level from **1–10**. **Level 2 — Light Enhancement** is the subtle default, so choosing a preset is optional if you want to keep it.
7. Launch Conquest Reborn normally.

**Quick upgrade:** Extract → Overwrite → Run Setup → Select Preset → Play.

The original **Ctrl+F7** advanced settings panel still works. The new 1–10 presets are selected using the separate Windows preset selector, **not** an in-game Ctrl+F7 slider. Existing custom managed graphics settings may be replaced when a preset is applied. Rerunning the setup script has not been independently validated on every installation.

**Release availability:** v1.1.0 remains the latest GitHub Release; v1.2.0 is currently a **local build only**. The download link at the top of this README points to v1.1.0, not v1.2.0.

**Validation:** The presets are conservative configuration profiles, **not GPU-benchmarked or independently tested in-game**. Performance and visual results vary by hardware. See `README-FIRST.txt` and `CHANGELOG-VeilForge.txt` inside the local ZIP for details.

## Graphics features

The Lumenveil engine provides:

- **3D volumetric fog:** ground mist, weather-aware haze, wind-driven fog, and distance atmosphere.
- **Sun and moon shafts:** light filtering past trees, buildings, and terrain.
- **Night illumination:** lanterns, torches, windows, and colored environmental light.
- **Spell lighting:** glowing projectiles and spell effects light nearby surfaces.
- **Water effects:** wind-driven waves, reflections, rain ripples, and sunlight glitter.
- **Optional wet surfaces and relief:** additional surface shading and simulated depth.
- **Regional looks:** per-zone visual tuning and day/night atmosphere.
- **Interactive controls:** `Ctrl+F7` opens the settings panel; `Ctrl+F12` compares enabled/disabled effects.

These are **upstream Lumenveil capabilities**, not new VeilForge-CoA engine features.

## Package contents

- Direct-extract renderer and DXVK files for the folder containing `Ascension.exe`.
- `VeilForge-Setup.cmd`, which generates lamp and liquid data locally from the player's own game files.
- License and third-party notices.
- **Local v1.2.0 package only:** `VeilForge-Preset-Selector.cmd`, `VeilForge-Apply-Preset.ps1`, and `VeilForge-Presets/Level-01.ini` through `Level-10.ini`.

Close the game and back up existing graphics DLLs and configuration files before extracting. Extract all contents directly into the game folder, not into a nested folder. Run `VeilForge-Setup.cmd` once, then launch the game. See `README-FIRST.txt` in the ZIP for full instructions.

The package targets `Ascension.exe`. Its Windows installation and in-game compatibility still need independent validation.

## Upstream visual gallery

[Browse the Lumenveil before-and-after comparison gallery](https://github.com/lumenveil/Lumenveil#before-and-after)

[View the upstream screenshot collection](https://github.com/lumenveil/Lumenveil/tree/main/docs/screenshots)

**Media attribution:** Images belong to their respective creators. The upstream screenshots were captured using Project Reforged HD assets and ReShade alongside Lumenveil. They do **not** depict the standard Conquest Reborn installation, and results will differ. This project will add separately labeled CR screenshots and videos when available.

## Compatibility and performance

Target: Windows 10/11 and the World of Warcraft **3.3.5a**-based Conquest Reborn client. Windows installation and in-game compatibility of v1.1.0 have not been independently tested. Performance depends on hardware, zone, view distance, and other graphics mods.

The upstream engine attaches to the running client to render its effects. Server rules or anti-cheat software may restrict such modifications; check applicable rules before installation. No affiliation or endorsement by Ascension or Blizzard is implied.

## Credits and source

- **Conquest Reborn adaptation and maintenance:** [Uncle Bone / uncle-bone](https://github.com/uncle-bone)
- **Original graphics engine and documentation:** [Lumenveil contributors](https://github.com/lumenveil/Lumenveil)
- **Underlying upstream renderer:** CoAVolFog by jealous-sound, as credited by Lumenveil.
- **DXVK:** Bundled with its license notice in the release package.

Upstream Lumenveil is licensed under the **GNU General Public License v2 (GPL-2.0)**. Any redistributed or modified engine binaries must be accompanied by the corresponding source and applicable license and third-party notices. VeilForge-CoA will retain upstream attribution rather than implying independent authorship of the engine.

[Original Lumenveil license](https://github.com/lumenveil/Lumenveil/blob/main/LICENSE) · [Third-party notices](https://github.com/lumenveil/Lumenveil/blob/main/THIRD-PARTY-NOTICES.md) · [Original legal notes](https://github.com/lumenveil/Lumenveil/blob/main/LEGAL.md)

---

*Independent community project for Conquest Reborn.*
