### Description
This patch adds default transparency parameters to config.h which specify the starting transparencies of all windows.

It also adds opacities to the ruleset, enabling override of the opacities on a per client basis.

Additionally, it adds some shortcuts:
```
[MODKEY]+[o]         -> increase focus opacity of currently focused window
[MODKEY]+[Shift]+[o] -> decrease focus opacity of currently focused window
```


### Download
- [git branch](https://codeberg.org/sevz/dwl/src/branch/client-opacity)
- [2024-06-07](https://codeberg.org/dwl/dwl-patches/raw/branch/main/patches/client-opacity/client-opacity.patch)

### Authors
- [sevz](https://codeberg.org/sevz)
