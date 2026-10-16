# Kixeye changes on top of lime 8.3.2

Branch `upgrade/lime-8.3.2` starts at upstream lime `8.3.2` (tag `upgrade-base-lime-8.3.2`).
This table lists every Kixeye commit from the old fork (`kixeye-bp`) and what happened to it here.

| Old fork commit | Change | Here | How |
|---|---|---|---|
| `db10a180` | Don't seek right after a sound starts playing | `a632347f` | Ported by hand (code moved) |
| `fc57ad48` | `fillRect` with alpha=0 doesn't return early | `de2b0dba` | Cherry-picked |
| `301be7c4` | Clipboard copy: Clipboard API fallback, prompt on failure, visible off-screen textarea | `eefc56bd` | Ported by hand. The debug `console.log` of copied text was left out. The accidental `tinyfiledialogs` submodule bump was left out |
| `6216c7fa` | Same, Haxe 3 compatible | `eefc56bd` | Folded into the commit above (Haxe 3 code not needed) |
| `cef6e6d7` | `getTimer()` on HTML5 uses `Date` | `96e0ce4d` | Ported by hand. Subtracts before converting to `Int`, so the value can't wrap |
| `235f7884` | Return focus to the game after copy/cut | `eefc56bd` | Folded into the clipboard commit |
| `3e2f759b` | Preloader `onError` event | — | Dropped: no game code listens for it (decision D8) |
| `5cc253d0` | Remove `failIfMajorPerformanceCaveat` | — | Already upstream: `a22d5576` (lime 7.9.0) |
| `2d33fe1c` | Disable `failIfMajorPerformanceCaveat` | — | Already upstream: `a22d5576` (lime 7.9.0) |
| `5618f6c1` | Clipboard text cleared to null on HTML5 | — | Already upstream: `0cf13bf3` (lime 8.1.3) |
| `620d5f29` | Gamepad polling and device motion off unless `-D gameDevicesEnabled` / `-D devicemotionEnabled` | `405e1509` | Ported by hand. The flag name is `gameDevicesEnabled` (with an "s"), as the old code used; the old commit message said `gameDeviceEnabled` |
| `b6710137` | Retry failed asset-library loads (5 by default, `-D lime-asset-library-load-retries=N`) | `b5630592` | Cherry-picked |
| `344ef259` | OpenAL submodule bump | — | Dropped: lime 8.3.2's own native library versions are used |

Native C libraries are upstream lime 8.3.2's pinned versions, unchanged.
