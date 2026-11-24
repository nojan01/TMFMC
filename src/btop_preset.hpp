// Modified for EBTOP. Changes copyright 2026 Norbert Jander.
// Copyright (c) 2026 Norbert Jander
// SPDX-License-Identifier: Apache-2.0
#pragma once
#include <optional>
#include <string>
#include <string_view>
#include <vector>

namespace LocalPreset {
inline bool gpu_available(std::string_view preset, int count) {
    while (not preset.empty()) {
        const auto end = preset.find(',');
        const auto token = preset.substr(0, end);
        const auto name = token.substr(0, token.find(':'));
        if (name.size() == 4 and name.substr(0, 3) == "gpu") {
            const int index = name[3] - '0';
            if (index < 0 or index >= count) return false;
        }
        if (end == std::string_view::npos) break;
        preset.remove_prefix(end + 1);
    }
    return true;
}
inline std::optional<int> next(const std::vector<std::string>& presets,
                              std::optional<int> current, int first,
                              bool forward, int gpu_count) {
    const int size = static_cast<int>(presets.size());
    if (size <= first) return std::nullopt;
    int index = current and *current >= first and *current < size
        ? *current : (forward ? first - 1 : size);
    for (int attempt = 0; attempt < size - first; ++attempt) {
        index += forward ? 1 : -1;
        if (index >= size) index = first;
        if (index < first) index = size - 1;
        if (gpu_available(presets[index], gpu_count)) return index;
    }
    return std::nullopt;
}
}
