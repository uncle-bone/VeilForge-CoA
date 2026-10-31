# VeilForge-CoA

**Atmospheric graphics enhancements for Ascension: Conquest of Azeroth — Conquest Reborn.**

VeilForge-CoA is an independent Conquest Reborn adaptation of the open-source [Lumenveil](https://github.com/lumenveil/Lumenveil) graphics mod for the World of Warcraft 3.3.5a client. The project is intended to simplify setup for the CR client (`Ascension.exe`) and provide a balanced starting configuration with DXVK packaged by default.

> **Project status:** Initial repository documentation. The CR-specific installer and bundled release have **not yet been published or validated**. Do not use the upstream installer unchanged and assume CR compatibility.

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

## Conquest Reborn adaptation goals

Our planned distribution will include:

1. Installation designed for **`Ascension.exe`** rather than the upstream `Wow.exe` assumption.
2. A sensible **balanced graphics preset**, without an imposed universal FPS cap.
3. **DXVK included by default**, with appropriate third-party notices.
4. Backups and conflict checks for existing graphics DLLs and configuration files.
5. Safe uninstall/restore behavior.
6. Local generation of lamp and liquid data from the player's own game installation rather than redistribution of extracted game data.

These are **development targets** until a tested build is released.

## Upstream visual gallery

[Browse the Lumenveil before-and-after comparison gallery](https://github.com/lumenveil/Lumenveil#before-and-after)

[View the upstream screenshot collection](https://github.com/lumenveil/Lumenveil/tree/main/docs/screenshots)

**Media attribution:** Images belong to their respective creators. The upstream screenshots were captured using Project Reforged HD assets and ReShade alongside Lumenveil. They do **not** depict the standard Conquest Reborn installation, and results will differ. This project will add separately labeled CR screenshots and videos when available.

## Compatibility and performance

Target: Windows 10/11 and the World of Warcraft **3.3.5a**-based Conquest Reborn client. Actual compatibility of the upcoming CR package remains subject to in-game testing. Performance depends on hardware, zone, view distance, and other graphics mods.

The upstream engine attaches to the running client to render its effects. Server rules or anti-cheat software may restrict such modifications; check applicable rules before installation. No affiliation or endorsement by Ascension or Blizzard is implied.

## Credits and source

- **Conquest Reborn adaptation and maintenance:** [Uncle Bone / downingwow](https://github.com/downingwow)
- **Original graphics engine and documentation:** [Lumenveil contributors](https://github.com/lumenveil/Lumenveil)
- **Underlying upstream renderer:** CoAVolFog by jealous-sound, as credited by Lumenveil.
- **DXVK:** Separate open-source graphics translation project, to be attributed in release packaging.

Upstream Lumenveil is licensed under the **GNU General Public License v2 (GPL-2.0)**. Any redistributed or modified engine binaries must be accompanied by the corresponding source and applicable license and third-party notices. VeilForge-CoA will retain upstream attribution rather than implying independent authorship of the engine.

[Original Lumenveil license](https://github.com/lumenveil/Lumenveil/blob/main/LICENSE) · [Third-party notices](https://github.com/lumenveil/Lumenveil/blob/main/THIRD-PARTY-NOTICES.md) · [Original legal notes](https://github.com/lumenveil/Lumenveil/blob/main/LEGAL.md)

---

*Independent community project for Conquest Reborn.*
