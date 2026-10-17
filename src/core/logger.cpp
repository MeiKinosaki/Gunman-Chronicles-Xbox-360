#include "logger.hpp"
#include <cstdio>

namespace gunman360 {
void log(LogLevel level, const char* message)
{
    const char* label = "INFO";
    if (level == LogLevel::Warning) label = "WARN";
    if (level == LogLevel::Error) label = "ERROR";
    std::printf("[Gunman360][%s] %s\n", label, message ? message : "(null)");
}
}
