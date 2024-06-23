### Description
Implements chained keybindings (like the dwm
[keychain](https://dwm.suckless.org/patches/keychain/) patch).

Bindings can share a leading chain key. This chain key will be triggered when
Mod+chain is pressed. A subsequent keypress will be matched against bindings
for that chain key. If it is configured the action will be triggered, otherwise
the keypress will be ignored.

### Download
- [git branch](https://codeberg.org/bencc/dwl/src/branch/chainkeys)
- [2024-05-20](https://codeberg.org/dwl/dwl-patches/raw/branch/main/patches/chainkeys/chainkeys.patch)

### Authors
- [Ben Collerson](https://codeberg.org/bencc)
