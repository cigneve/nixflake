### Description
Stacker is a patch that allows moving around the stack more freely. With only
one keybinding, quickly move, swap and jump around the window stack.

1. Focus any window of the stack with a single key binding.
2. Swap the currently focused windows with any other window in the stack.
3. Move the selected window in the stack with `relativeswap`.

This patch is heavily inspired by the original [stacker](https://dwm.suckless.org/patches/stacker/) dwm patch.

### Keybinding

- `MODKEY` + {`q`, `w`, `e`, `r`}: jump to the first, second, third and last
  window of the stack
- `MODKEY` + `SHIFT` + {`Q`, `W`, `E`, `R`}: swap the selected with the first, second, third and last
  window of the stack
- `MODKEY` + `SHIFT` + {`J`, `K`}: move the selected window up & down the stack

### Missing feature

Jumping to the last selected window is not yet implemented.

### Download
- [git branch](https://codeberg.org/jeromecst/dwl/src/branch/stacker)
- [2024-05-17](https://codeberg.org/dwl/dwl-patches/raw/branch/main/patches/stacker/stacker.patch)

### Authors
- [jeromecst](https://codeberg.org/jeromecst)
