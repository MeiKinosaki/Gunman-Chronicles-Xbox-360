#pragma once

namespace gunman360 {
class Runtime {
public:
    bool initialize();
    int run();
    void shutdown();
private:
    bool initialized_ = false;
};
}
