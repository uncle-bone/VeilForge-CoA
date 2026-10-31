# VeilForge-CoA

**Atmospheric graphics enhancements for Ascension: Conquest of Azeroth — Conquest Reborn.**

[**Download VeilForge-CoA v1.0.0**](https://github.com/downingwow/VeilForge-CoA/releases/download/v1.0.0/VeilForge-CoA-v1.0.0.zip) · [Release notes](https://github.com/downingwow/VeilForge-CoA/releases/tag/v1.0.0)

VeilForge-CoA is an independent Conquest Reborn adaptation of the open-source [Lumenveil](https://github.com/lumenveil/Lumenveil) graphics mod for the World of Warcraft 3.3.5a client. It packages setup and removal scripts, DXVK, the CoAVolFog/Lumenveil renderer, and a helper that generates lamp and liquid data from the player's own game installation.

> **Release status:** v1.0.0 is published. The package was assembled and its structure checked, but Windows installation and in-game compatibility have not been independently tested. Review `README-FIRST.txt` and the included notices before use.

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

- Installer and uninstaller scripts, with existing graphics files backed up in `VeilForge-Backup`.
- DXVK included by default.
- A setup helper that generates lamp and liquid data locally from the player's own game files.
- CoAVolFog/Lumenveil renderer configuration for the Ascension client.

The v1.0.0 package targets `Ascension.exe`. Its installation and in-game compatibility still need independent validation.

## Upstream visual gallery

[Browse the Lumenveil before-and-after comparison gallery](https://github.com/lumenveil/Lumenveil#before-and-after)

[View the upstream screenshot collection](https://github.com/lumenveil/Lumenveil/tree/main/docs/screenshots)

**Media attribution:** Images belong to their respective creators. The upstream screenshots were captured using Project Reforged HD assets and ReShade alongside Lumenveil. They do **not** depict the standard Conquest Reborn installation, and results will differ. This project will add separately labeled CR screenshots and videos when available.

## Compatibility and performance

Target: Windows 10/11 and the World of Warcraft **3.3.5a**-based Conquest Reborn client. Windows installation and in-game compatibility of v1.0.0 have not been independently tested. Performance depends on hardware, zone, view distance, and other graphics mods.

The upstream engine attaches to the running client to render its effects. Server rules or anti-cheat software may restrict such modifications; check applicable rules before installation. No affiliation or endorsement by Ascension or Blizzard is implied.

## Credits and source

- **Conquest Reborn adaptation and maintenance:** [Uncle Bone / downingwow](https://github.com/downingwow)
- **Original graphics engine and documentation:** [Lumenveil contributors](https://github.com/lumenveil/Lumenveil)
- **Underlying upstream renderer:** CoAVolFog by jealous-sound, as credited by Lumenveil.
- **DXVK:** Bundled with its license notice in the release package.

Upstream Lumenveil is licensed under the **GNU General Public License v2 (GPL-2.0)**. Any redistributed or modified engine binaries must be accompanied by the corresponding source and applicable license and third-party notices. VeilForge-CoA will retain upstream attribution rather than implying independent authorship of the engine.

[Original Lumenveil license](https://github.com/lumenveil/Lumenveil/blob/main/LICENSE) · [Third-party notices](https://github.com/lumenveil/Lumenveil/blob/main/THIRD-PARTY-NOTICES.md) · [Original legal notes](https://github.com/lumenveil/Lumenveil/blob/main/LEGAL.md)

---

*Independent community project for Conquest Reborn.*
