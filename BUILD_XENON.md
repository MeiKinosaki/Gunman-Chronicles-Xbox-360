# Gunman360 — Xenon ELF build (v0.2b)

This repository currently contains a **minimal bootstrap**, not a playable port of
Gunman Chronicles. The original game's engine and source have not been added here.

## First target

The first artifact target is:

`build/elf/Xenon.elf`

The Makefile expects a compatible Xenon cross-compiler named `xenon-g++` by
default. Toolchain names, startup objects, linker scripts, and libXenon link flags
can vary by installation, so supply the correct options for the installed toolchain.

Inspect the configuration:

```sh
make show-config
```

Attempt the ELF build only in an environment where the Xenon toolchain and its
dependencies are installed:

```sh
make xenon-elf
```

For a non-default installation, override variables, for example:

```sh
make xenon-elf XENON_CXX=/path/to/xenon-g++
```

The example above changes only the compiler path; it does not provide any missing
platform libraries or startup objects.

## Validation gates

- [ ] Build completes using the actual target toolchain.
- [ ] Output is identified as a PowerPC/Xenon-compatible ELF.
- [ ] Linker dependencies and entry point are verified.
- [ ] ELF is tested in a compatible Xbox 360 development environment.
- [ ] Only after ELF validation, determine the correct conversion procedure for
      the installed `elf2xex` tool and produce `default.xex`.
- [ ] Test the resulting XEX on the intended hardware.

No ELF or XEX binary is checked into the repository by this scaffold. A successful
GitHub commit is not evidence that compilation or hardware testing has occurred.
