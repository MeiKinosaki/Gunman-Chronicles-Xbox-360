#include "core/runtime.hpp"
#include <cassert>

int main()
{
    gunman360::Runtime runtime;

    // Running before initialization must fail.
    assert(runtime.run() == 1);

    // The bootstrap lifecycle should complete successfully.
    assert(runtime.initialize());
    assert(runtime.run() == 0);

    runtime.shutdown();

    // Running after shutdown must fail until initialized again.
    assert(runtime.run() == 1);
    assert(runtime.initialize());
    assert(runtime.run() == 0);
    runtime.shutdown();
    return 0;
}
