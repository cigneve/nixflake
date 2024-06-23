### Description
Largely based on [raphi](https://sr.ht/~raphi/)'s [somebar](https://sr.ht/~raphi/somebar/), this patch provides an ipc for wayland clients to get and set dwl state. The ipc is intended for status bars, but can also be scripted with tools like [dwlmsg](https://codeberg.org/notchoc/dwlmsg).

Status information to stdout is currently disabled as dwl tends to freeze. For now, `dwlmsg -w` should act as a drop-in replacement.

### Download
- [git branch](https://codeberg.org/notchoc/dwl/src/branch/ipc)
- [2024-06-21](https://codeberg.org/dwl/dwl-patches/raw/branch/main/patches/ipc/ipc.patch)
- [2024-06-19](https://codeberg.org/dwl/dwl-patches/raw/commit/e69afc7263b8d982a7923e5d4910f2e1f7140bb8/patches/ipc/ipc.patch)
- [2024-06-08](https://codeberg.org/dwl/dwl-patches/raw/commit/f8598a91b44acc3bd7e9041be97265bbce8fa219/patches/ipc/ipc.patch)
- [2024-03-13](https://codeberg.org/dwl/dwl-patches/raw/commit/0150cfebbcd85f2d6e6728afad345a11a0c45947/ipc/ipc.patch)
- [2024-02-20](https://codeberg.org/dwl/dwl-patches/raw/commit/0c5ae06e4bc1d7f641376e8fcb86b43bd48ce2ee/ipc/ipc.patch)
- [2023-10-28](https://gist.githubusercontent.com/fbushstone/b116c44340eb7a7878de1119dd931ca5/raw/ee66ac9e2a5dddd9b528df553e21080c2811e974/ipc-v2-fixed.patch) Updated version of 2023-04-29, prevents ipc from freezing the compositor in printstatus.
- [2023-04-29](https://github.com/djpohly/dwl/compare/main...madcowog:ipc-v2.patch) Use this for dwl-ipc-unstable-v2. If you are using commit [9d68554](https://github.com/djpohly/dwl/commit/9d68554c59a886b641d27a364884fb461af2d4f1) or later, use this. For status bars this protocol is supported by dwlb, Waybar and dwl-bar.
- [2023-04-29](https://github.com/djpohly/dwl/compare/main...madcowog:ipc-bbdf2.patch) Use this for dwl-ipc-unstable-v1. If you are using commit [bbdaf2a9](https://github.com/djpohly/dwl/commit/bbdf2a913b72e7a308ee0dfde6518a4285d4a775), [release 0.4](https://github.com/djpohly/dwl/releases/tag/v0.4) or earlier, use this. For status bars, this protocol is supported by dwl-bar.
- [2023-02-20](https://lists.sr.ht/~raphi/public-inbox/patches/39166) Use this for net-tapesoftware-dwl-wm-unstable-v1. If you are using commit [c69a2bec](https://github.com/djpohly/dwl/commit/c69a2bec3ff417fbc4ea8fec0a49096773e01e7d) or later, use this. For status bars this protocol is supported by somebar.

### Authors
- [MadcowOG](https://github.com/MadcowOG)
- [fbushstone](https://github.com/fbushstone)
- [notchoc](https://codeberg.org/notchoc)
- [snuk](https://codeberg.org/snuk)
