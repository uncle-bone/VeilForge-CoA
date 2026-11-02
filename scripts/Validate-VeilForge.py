from __future__ import annotations

import argparse
import csv
import pathlib
import re
import zipfile


def fail(message: str) -> None:
    raise SystemExit(f"FAIL: {message}")


def read_values(text: str) -> dict[str, str]:
    return dict(re.findall(r"(?m)^\s*([A-Za-z][A-Za-z0-9_]*)\s*=\s*([^;\r\n]+)", text))


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--root", required=True, type=pathlib.Path)
    parser.add_argument("--lumenveil-default", required=True, type=pathlib.Path)
    args = parser.parse_args()
    root = args.root
    presets_dir = root / "presets"
    header = (root / "engine-overrides" / "veilforge_presets.h").read_text(encoding="utf-8")
    source_config = (root / "engine-overrides" / "settings_panel.cpp").read_text(encoding="utf-8")
    source_tables = (root / "engine-overrides" / "presets.cpp").read_text(encoding="utf-8")

    levels = []
    for level in range(1, 11):
        path = presets_dir / f"Level-{level:02}.ini"
        if not path.is_file():
            fail(f"missing {path.name}")
        levels.append(read_values(path.read_text(encoding="utf-8-sig")))

    managed = (root / "engine-overrides" / "veilforge-preset-keys.txt").read_text(encoding="utf-8").splitlines()
    if len(managed) != len(set(managed)):
        fail("preset key list contains duplicates")
    if set(managed) & {"DebugView", "DrawLog", "PerfLog", "LogLevel", "SunMarker", "Underwater"}:
        fail("preset key list must preserve diagnostics and live context toggles")

    bindings: list[dict[str, str]] = []
    for level in range(1, 11):
        block = re.search(rf"kPreset{level:02}\[\]\s*=\s*\{{(.*?)\n\}};", header, re.S)
        if not block:
            fail(f"missing compiled data for level {level}")
        entries = dict(re.findall(r'\{"([A-Za-z][A-Za-z0-9_]*)",\s*(-?\d+(?:\.\d+)?)(?:f)?\}', block.group(1)))
        if set(entries) != set(managed):
            fail(f"level {level} does not contain exactly {len(managed)} managed settings")
        if len(entries) != len(managed):
            fail(f"level {level} has duplicate or missing settings")
        for key in managed:
            if float(entries[key]) != float(levels[level - 1][key]):
                fail(f"compiled level {level} value for {key} differs from its source profile")
        bindings.append(entries)

    config_source = root / "engine-overrides" / "config-live-setting-keys.txt"
    supported = set(config_source.read_text(encoding="utf-8").splitlines())
    excluded = {"DebugView", "DrawLog", "PerfLog", "LogLevel", "SunMarker", "Underwater"}
    if set(managed) != supported - excluded:
        fail("preset key list must include every visual setting and preserve diagnostics/context controls")
    if set(managed) - supported:
        fail(f"unsupported renderer fields: {sorted(set(managed) - supported)}")
    with (root / "engine-overrides" / "config-live-setting-ranges.csv").open(newline="", encoding="utf-8") as file:
        ranges = {row["key"]: (float(row["min"]), float(row["max"])) for row in csv.DictReader(file)}
    for level, values in enumerate(levels, 1):
        for key in managed:
            value = float(values[key])
            low, high = ranges[key]
            if not low <= value <= high:
                fail(f"level {level} value {key}={value} is outside renderer range {low}..{high}")
    if "LiveSettingStored" not in source_tables or "FindLiveSetting" not in source_tables:
        fail("preset implementation is not bound to the renderer's live setting registry")
    if "DrawVeilForgePreset(edited)" not in source_config or '"Custom"' not in source_tables:
        fail("in-game preset selector or Custom indicator is missing")

    signatures = [tuple(sorted(values.items())) for values in bindings]
    if len(set(signatures)) != 10:
        fail("two or more selectable levels have identical managed settings")

    for level, values in enumerate(levels, 1):
        for key in ("LightShafts", "TerrainShadows"):
            expected = 1.0
            if float(values[key]) != expected:
                fail(f"{key} must be enabled at every preset level (level {level})")
        if float(values["GodRays"]) != 0.0:
            fail(f"GodRays must remain off in level {level}")

    if [int(values["Quality"]) for values in levels] != [1, 1, 2, 2, 2, 2, 2, 3, 3, 3]:
        fail("quality tiers do not match the tuned 1/2/3 progression")
    for key in ("WetSurfaces", "Puddles", "WaterMemory", "ReliefModels"):
        if any(float(values[key]) != 0.0 for values in levels[:4]) or any(float(values[key]) < 1.0 for values in levels[4:]):
            fail(f"{key} must be enabled from the Lumenveil baseline at level 5")
    if any(float(values["LiquidDepth"]) != 1.0 for values in levels):
        fail("LiquidDepth must be enabled in every level for its water controls to work")
    if [int(values["Banks"]) for values in levels] != [0, 0, 1, 1, 1, 2, 2, 2, 2, 2]:
        fail("bank modes are not stepped by profile tier")

    with zipfile.ZipFile(root / "assets" / "VeilForge-CoA-v1.2.0-Local-Presets.zip") as archive:
        default = read_values(archive.read("CoAVolFog.ini").decode("utf-8-sig"))
    if any(float(default[key]) != float(levels[1][key]) for key in managed):
        fail("Level 2 no longer matches the current package default")
    if levels[1].get("ZoneDensity", "").strip().lower() != "none":
        fail("Level 2 package default must not suppress fog through inherited per-zone multipliers")
    lumenveil_default = read_values(args.lumenveil_default.read_text(encoding="utf-8-sig"))
    for key in managed:
        if float(levels[4][key]) != float(lumenveil_default[key]):
            fail(f"Level 5 must match the Lumenveil default for {key}")
    anchors = {
        "Density": 1.0,
        "DataMode": 1.0,
        "LightShafts": 1.0,
        "TerrainShadows": 1.0,
        "LampFog": 1.0,
        "LampDayLight": 0.35,
        "LiquidDepth": 1.0,
    }
    for key, expected in anchors.items():
        if float(levels[4][key]) != expected:
            fail(f"Level 5 must match the Lumenveil default for {key}")
    for key in ("Density", "Haze", "GroundFog", "FarFog", "LampFog", "LampDayLight", "WaterReflect", "WaterGlitter", "WaterWaves"):
        if float(levels[9][key]) <= float(lumenveil_default[key]):
            fail(f"Level 10 must exceed the Lumenveil default for {key}")
    for key in ("LowSunLight", "LowSunShafts", "Shafts", "ShaftHaze", "MoonShafts", "SunScatter"):
        if float(levels[9][key]) <= float(lumenveil_default[key]):
            fail(f"Level 10 must strengthen the Lumenveil default for {key}")
    for key, maximum in (("Shafts", 4.0), ("LowSunShafts", 3.0), ("MoonShafts", 8.0), ("WeatherShafts", 1.0)):
        if float(levels[9][key]) != maximum:
            fail(f"Level 10 must use the full supported {key} strength")
    if float(levels[9]["WeatherFog"]) > 1.3:
        fail("Level 10 weather fog must preserve enough scene contrast for lighting")
    for key in ("Density", "Haze", "GroundFog", "FarFog", "CloudShadows", "CloudCover", "LampFog", "LampDayLight", "WaterReflect", "WaterGlitter", "WaterClarity", "WaterWaves", "SunScatter", "Shafts", "WeatherShafts"):
        values = [float(level[key]) for level in levels]
        if any(after < before for before, after in zip(values, values[1:])):
            fail(f"{key} must rise consistently through the ten levels")

    print(f"PASS: 10 distinct in-game profiles cover all {len(managed)} supported graphics settings")
    print("PASS: Level 5 matches Lumenveil defaults; Levels 6-10 exceed the baseline")
    print("PASS: Level 2 matches the packaged default; profile data matches the compiled table")


if __name__ == "__main__":
    main()
