#pragma once

namespace gunman360 {
enum class LogLevel { Info, Warning, Error };
void log(LogLevel level, const char* message);
}
