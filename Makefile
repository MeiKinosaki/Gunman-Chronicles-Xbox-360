# Gunman360 v0.2b. Xenon options must match the installed toolchain.
XENON_CXX      ?= xenon-g++
XENON_CXXFLAGS ?= -O2 -Wall -Wextra -std=gnu++11
XENON_LDFLAGS  ?=
XENON_LIBS     ?=
HOST_CXX       ?= c++
HOST_CXXFLAGS  ?= -O2 -Wall -Wextra -std=c++11 -pedantic

SRC := src/main.cpp src/core/runtime.cpp src/core/logger.cpp
BUILD_DIR := build
ELF := $(BUILD_DIR)/elf/Xenon.elf
HOST_TEST := $(BUILD_DIR)/host/gunman360-smoke-test

.PHONY: all xenon-elf host-test clean show-config
all: xenon-elf

xenon-elf: $(ELF)

$(ELF): $(SRC)
	mkdir -p $(BUILD_DIR)/elf
	$(XENON_CXX) $(XENON_CXXFLAGS) -Isrc $(SRC) $(XENON_LDFLAGS) $(XENON_LIBS) -o $@
	@echo "ELF output: $@ (verify format and target dependencies before hardware testing)"

$(HOST_TEST): $(SRC)
	mkdir -p $(BUILD_DIR)/host
	$(HOST_CXX) $(HOST_CXXFLAGS) -Isrc $(SRC) -o $@

host-test: $(HOST_TEST)
	./$(HOST_TEST)

show-config:
	@echo "XENON_CXX=$(XENON_CXX)"
	@echo "XENON_CXXFLAGS=$(XENON_CXXFLAGS)"
	@echo "XENON_LDFLAGS=$(XENON_LDFLAGS)"
	@echo "XENON_LIBS=$(XENON_LIBS)"
	@echo "HOST_CXX=$(HOST_CXX)"

clean:
	rm -rf $(BUILD_DIR)
