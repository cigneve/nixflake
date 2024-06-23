### Description
This patch allows you to add keybindings to the lockscreen.

```c
static const Key lockedkeys[] = {
	/* Note that Shift changes certain key codes: c -> C, 2 -> at, etc. */
	/* modifier                  key                 function        argument */

	/* Ctrl-Alt-Backspace and Ctrl-Alt-Fx used to be handled by X server */
	{ WLR_MODIFIER_CTRL|WLR_MODIFIER_ALT,XKB_KEY_Terminate_Server, quit, {0} },
#define CHVT(n) { WLR_MODIFIER_CTRL|WLR_MODIFIER_ALT,XKB_KEY_XF86Switch_VT_##n, chvt, {.ui = (n)} }
	CHVT(1), CHVT(2), CHVT(3), CHVT(4), CHVT(5), CHVT(6),
	CHVT(7), CHVT(8), CHVT(9), CHVT(10), CHVT(11), CHVT(12),
};
```

### Download
- [git branch](https://codeberg.org/wochap/dwl/src/branch/v0.5/lockedkeys)
- [2024-04-11](https://codeberg.org/dwl/dwl-patches/raw/commit/fc4146f3068dcd46035a2a11fe9d6109a97ae6d6/lockedkeys/lockedkeys.patch)
- [v0.5](https://codeberg.org/dwl/dwl-patches/raw/commit/2a6560c167e5c9afc5598ac5431d23d90de8846c/lockedkeys/lockedkeys.patch)

### Authors
- [wochap](https://codeberg.org/wochap)
