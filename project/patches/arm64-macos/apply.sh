#!/bin/sh
# Applies the Apple Silicon (arm64 macOS) fixes to lime's bundled native
# library submodules. Safe to run repeatedly; already-applied patches are
# skipped. All changes are gated on HXCPP_ARM64 / __aarch64__ / macOS, so
# Windows, Linux and x86_64 macOS builds compile exactly as before.
set -e
cd "$(dirname "$0")/../.."   # -> project/
for lib in freetype pixman png sdl openal zlib; do
	patch="patches/arm64-macos/$lib.patch"
	if git -C "lib/$lib" apply --reverse --check "../../$patch" 2>/dev/null; then
		echo "$lib: already applied"
	else
		git -C "lib/$lib" apply "../../$patch"
		echo "$lib: applied"
	fi
done
