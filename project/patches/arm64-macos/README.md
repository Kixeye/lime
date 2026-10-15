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

Build (needs hxp >= 1.2 for Apple Silicon detection, hxcpp >= 4.3.175 from
https://github.com/HaxeFoundation/hxcpp/releases (haxelib's 4.3.2 lacks the
macOS SDK-detection and arm64 library-name fixes), plus Xcode):

```sh
project/patches/arm64-macos/apply.sh
haxelib run lime rebuild mac
# -> ndll/MacArm64/lime.ndll (arm64)
```

On Apple Silicon, `lime rebuild mac` builds arm64 (MacPlatform.rebuild) and
the lime tools load the ndll from ndll/MacArm64/ (upstream 1ebce5fa).
