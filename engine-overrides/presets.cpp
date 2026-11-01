#include "presets.h"

#include "veilforge_presets.h"

#include <array>
#include <vector>

namespace veilforge
{
namespace
{
struct BoundValue
{
    int setting;
    float value;
};

using Preset = std::vector<BoundValue>;

const std::array<Preset, 10>& Presets()
{
    static const std::array<Preset, 10> presets = [] {
        std::array<Preset, 10> result;
        for (int level = 0; level < static_cast<int>(result.size()); ++level)
        {
            result[level].reserve(kPresetSettingCount);
            for (std::size_t item = 0; item < kPresetSettingCount; ++item)
            {
                const PresetValue& source = kPresets[level][item];
                const int setting = FindLiveSetting(source.key);
                if (setting >= 0)
                    result[level].push_back({setting, source.value});
            }
        }
        return result;
    }();
    return presets;
}

bool Matches(const Config& config, const Preset& preset)
{
    for (const BoundValue& value : preset)
    {
        if (LiveSettingStored(value.setting, LiveSettingValue(config, value.setting)) !=
            LiveSettingStored(value.setting, value.value))
            return false;
    }
    return true;
}
} // namespace

const char* PresetName(int level)
{
    return level >= 1 && level <= 10 ? kPresetNames[level - 1] : "Custom";
}

int MatchingPreset(const Config& config)
{
    const auto& presets = Presets();
    for (int level = 0; level < static_cast<int>(presets.size()); ++level)
        if (presets[level].size() == kPresetSettingCount && Matches(config, presets[level]))
            return level + 1;
    return 0;
}

bool ApplyPreset(Config& config, int level)
{
    if (level < 1 || level > 10)
        return false;
    bool changed = false;
    for (const BoundValue& value : Presets()[level - 1])
    {
        const float before = LiveSettingStored(value.setting, LiveSettingValue(config, value.setting));
        const float after = LiveSettingStored(value.setting, value.value);
        if (before == after)
            continue;
        SetLiveSettingValue(config, value.setting, value.value);
        changed = true;
    }
    return changed;
}
} // namespace veilforge
