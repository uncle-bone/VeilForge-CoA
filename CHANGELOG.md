# Changelog

## 1.3.5
- Keep both "Remember what was seen" options unchecked by default and independent of preset selection.
- Strengthen shaft effects at Levels 6-10 while reducing sun scatter and glare to avoid an over-bright sun.
- Retain the Level 5 Lumenveil baseline across all 133 preset-managed graphics controls.

## 1.3.4
- Enable light shafts and terrain shadows at all ten preset levels.
- Strengthen sun scatter, sun/moon shafts, and low-sun lighting progressively through the upper tiers.
- Stop storm weather from suppressing shafts and restrain upper-tier weather fog to preserve scene contrast.


## 1.3.3
- Apply all 135 renderer graphics settings from each in-game preset, including light shafts, terrain shadows, low-sun lighting, lanterns, moon shafts, and material relief.
- Set Level 5 to the pinned Lumenveil defaults for every preset-managed graphics option; tune Levels 1–4 below and Levels 6–10 above those baselines.
- Keep diagnostics and live context toggles under player control.


## 1.3.2
- Set Level 5 to Lumenveil's shipped defaults across all 60 preset-managed controls.
- Tune Levels 1–4 below that baseline and Levels 6–10 above it, with a stronger maximum profile.
- Normalize the packaged default zone-density list and enable liquid-depth data at all levels.
- Expand uninstall cleanup to remove VeilForge documentation/config files and verify core files are gone, while preserving DXVK.

## 1.3.1
- Fix setup script detection and running-game checks for both Wow.exe and Ascension.exe.
- Add VeilForge-Uninstall.cmd with support for both executable names.
- Include uninstall guidance and validate both scripts in the install package.

## 1.3.0
- Integrate ten graphics profiles into the renderer's Ctrl+F7 panel.
- Use Level 2 - Subtle as the packaged default.
- Limit applying profiles to the 60 managed renderer settings; preserve zone data, key bindings, diagnostics, and other configuration.
- Show Custom when managed settings no longer match a profile; retain the renderer's Save and Revert behavior.
- Stage costly surface effects in the upper tiers and keep artifact-prone shafts disabled.
- Add profile validation, renderer harness coverage, and a pinned Windows x86 build workflow.
- Published as a stable release after successful Windows build and package verification; in-game and hardware testing are still required.
