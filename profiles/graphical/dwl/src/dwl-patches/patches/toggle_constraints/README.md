### Description
Adds a function called togglepointerconstraints to turn pointer constraint enforcement on and off with a keybind. 

### Usage
Add a binding for the togglepointerconstraints function in the keys[] array of config.h. The function does not take any argument. Pointer constraints default to enabled, and can be toggled on and off with the function from there.

Example:
```
{ MODKEY, XKB_KEY_c, togglepointerconstraints, {0}},
```

### Download
- [Git branch](https://codeberg.org/thanatos/dwl/src/branch/toggle_constraints)
- [2024-03-26](https://codeberg.org/dwl/dwl-patches/raw/branch/main/patches/toggle_constraints/toggle_constraints)

### Authors
- [thanatos](https://codeberg.org/thanatos)