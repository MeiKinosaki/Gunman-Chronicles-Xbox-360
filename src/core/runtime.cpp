#include "runtime.hpp"
#include "logger.hpp"

namespace gunman360 {
bool Runtime::initialize()
{
    if (initialized_) {
        log(LogLevel::Warning, "Runtime initialize called more than once.");
        return true;
    }
    log(LogLevel::Info, "Runtime bootstrap starting.");
    initialized_ = true;
    log(LogLevel::Info, "Runtime bootstrap initialized; game systems are not implemented yet.");
    return true;
}

int Runtime::run()
{
    if (!initialized_) {
        log(LogLevel::Error, "Runtime run requested before initialization.");
        return 1;
    }
    log(LogLevel::Info, "Bootstrap smoke run completed.");
    return 0;
}

void Runtime::shutdown()
{
    if (!initialized_) return;
    log(LogLevel::Info, "Runtime shutdown.");
    initialized_ = false;
}
}
