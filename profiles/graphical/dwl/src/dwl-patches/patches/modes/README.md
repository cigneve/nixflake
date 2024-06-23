### Description
Implement  modes, that way each mapping is associated with a mode and is only active while in that mode, default mode is `NORMAL`

### Example

In the example below, you declare a mode: `BROWSER`, which is activated when you press <kbd>modkey</kbd> + <kbd>b</kbd>. Then, you can press <kbd>f</kbd> to launch `Firefox` and return to the default `NORMAL` mode.

```c
enum {
  BROWSER,
};
const char *modes_labels[] = {
  "browser",
};

static const Key keys[] = {
  // ...
  { MODKEY, XKB_KEY_b, entermode, {.i = BROWSER} },
  // ...
};

static const Modekey modekeys[] = {
  /* mode      modifier                  key                 function        argument */
  { BROWSER, { 0, XKB_KEY_f, spawn, SHCMD("firefox") } },
  { BROWSER, { 0, XKB_KEY_f, entermode, {.i = NORMAL} } },
  { BROWSER, { 0, XKB_KEY_Escape, entermode, {.i = NORMAL} } },
};
```

### Download
- [git branch](https://codeberg.org/wochap/dwl/src/branch/v0.5/modes)
- [v0.5](https://codeberg.org/dwl/dwl-patches/raw/branch/main/patches/modes/modes.patch)

### Authors
- [wochap](https://codeberg.org/wochap)
