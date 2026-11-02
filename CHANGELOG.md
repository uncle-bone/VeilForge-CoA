# Changelog

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
