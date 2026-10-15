# arm64 macOS (Apple Silicon) native build

The submodules in `project/lib/` point at `native-toolkit/*`, which we
can't push to, so their fixes live here as patches. The submodule
pointers are unchanged.

| Patch | Problem on arm64 / current macOS SDK | Fix |
| --- | --- | --- |
| freetype | bundled gzip clashes with SDK zlib (`unknown type name 'Byte'`) | `FT_CONFIG_OPTION_SYSTEM_ZLIB` + lime zlib include, as upstream lime |
| pixman | `-mmmx`/`-msse*` unsupported on arm64 | x86 flags/files skipped on `HXCPP_ARM64`; SSE defines skipped on `__aarch64__` |
| png | `fp.h` not found; NEON symbols missing | drop `TARGET_OS_MAC` from classic-Mac check (libpng 1.6.36+); NEON files for `mac HXCPP_ARM64` |
| sdl | x86 flags; `OSAtomicCompareAndSwap32Barrier` undeclared | x86 flags skipped on arm64; `HAVE_GCC_ATOMICS` on `__aarch64__` |
| openal | x86 flags | skipped on `HXCPP_ARM64` |
| zlib | `fdopen` redefined, breaks SDK `_stdio.h` | test `MACOS` only (zlib 1.2.12 fix) |

Build (needs hxcpp >= 4.3 and Xcode):

```sh
project/patches/arm64-macos/apply.sh
cd project
haxelib run hxcpp Build.xml -Dmac -DHXCPP_CLANG -DHXCPP_M64 -DHXCPP_ARM64 -DMACOSX_VER=$(xcrun --show-sdk-version)
# lime 7.6's CFFI loader looks in ndll/Mac64/
ln -sf ../MacArm64/lime-64.ndll ../ndll/Mac64/lime.ndll
```

Don't use `lime rebuild mac`, which builds x86_64 only on this lime version.
