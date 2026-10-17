#include "core/runtime.hpp"

int main()
{
    gunman360::Runtime runtime;
    if (!runtime.initialize()) return 1;
    const int result = runtime.run();
    runtime.shutdown();
    return result;
}
