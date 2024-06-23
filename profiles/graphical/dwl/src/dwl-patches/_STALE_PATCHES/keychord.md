### Description

This patch implements sequences for chained keybindings (like the dwm [keychord](https://dwm.suckless.org/patches/keychord/) patch).

_Notes_: 
- The maximum number of sequences is set to `5` in the `Keychord` struct for a given keybinding
- This original motivation was better support for [stumpwm](https://stumpwm.github.io/) style of keybindings, however this is not a limitation

### Example

The default values for `MODKEY` and `PREFIXKEY` can be changed in `config.def.h` and/or `config.h`.

#### emacs-like

In the example below, the `firefox` command is bound to the key sequence `alt-s alt-u f`.

```C
static const Keychord keychords[] = {
  /* Note that Shift changes certain key codes: c -> C, 2 -> at, etc. */
  /* count key_sequences                          function  argument */
  { 3, {{MODKEY, XKB_KEY_s}, {MODKEY, XKB_KEY_u}, {MOD_NONE, XKB_KEY_f}}, spawn, SHCMD("firefox") },
};
```

#### vim-like

In the example below, the `firefox` command is bound to the key sequence `alt-s u f`.

```C
static const Keychord keychords[] = {
  /* Note that Shift changes certain key codes: c -> C, 2 -> at, etc. */
  /* count key_sequences                          function  argument */
  { 3, {{MODKEY, XKB_KEY_s}, {MOD_NONE, XKB_KEY_u}, {MOD_NONE, XKB_KEY_f}}, spawn,SHCMD("firefox") },
};
```

### Download

- [2023-03-12](https://github.com/djpohly/dwl/compare/main...yveszoundi:dwl-customization:keychord-2023-03-12.patch)
- [2023-02-15](https://github.com/djpohly/dwl/compare/main...yveszoundi:dwl-customization:v0.4-keychord-2023-02-15.patch)

### Authors

- [Yves Zoundi](https://github.com/yveszoundi)