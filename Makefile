# Gunman360 v0.2b — configurable Xenon ELF scaffold.
# Toolchain flags and libXenon link options depend on the installed toolchain.
# Override XENON_CXXFLAGS / XENON_LDFLAGS / XENON_LIBS for your environment.

XENON_CXX       ?= xenon-g++
XENON_CXXFLAGS  ?= -O2 -Wall -Wextra -std=gnu++11
XENON_LDFLAGS   ?=
XENON_LIBS      ?=

SRC             := src/main.cpp
BUILD_DIR       := build
OBJ_DIR         := $(BUILD_DIR)/obj
ELF_DIR         := $(BUILD_DIR)/elf
OBJ             := $(OBJ_DIR)/main.o
ELF             := $(ELF_DIR)/Xenon.elf

.PHONY: all xenon-elf clean show-config

all: xenon-elf

xenon-elf: $(ELF)

$(OBJ_DIR) $(ELF_DIR):
	mkdir -p $@

$(OBJ): $(SRC) | $(OBJ_DIR)
	$(XENON_CXX) $(XENON_CXXFLAGS) -c $< -o $@

$(ELF): $(OBJ) | $(ELF_DIR)
	$(XENON_CXX) $(XENON_CXXFLAGS) $(XENON_LDFLAGS) $^ $(XENON_LIBS) -o $@
	@echo "ELF output: $(ELF)"
	@echo "Verify the file format and dependencies before attempting hardware execution."

show-config:
	@echo "XENON_CXX=$(XENON_CXX)"
	@echo "XENON_CXXFLAGS=$(XENON_CXXFLAGS)"
	@echo "XENON_LDFLAGS=$(XENON_LDFLAGS)"
	@echo "XENON_LIBS=$(XENON_LIBS)"

clean:
	rm -rf $(BUILD_DIR)
