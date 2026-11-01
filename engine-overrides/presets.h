#pragma once

#include "config.h"

namespace veilforge
{
const char* PresetName(int level);
int MatchingPreset(const Config& config);
bool ApplyPreset(Config& config, int level);
} // namespace veilforge
