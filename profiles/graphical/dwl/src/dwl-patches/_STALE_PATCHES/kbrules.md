### Description
Allow for keyboard rules to be used; This allows for keyboard-specific options or layouts.

The keyboard's names can be retrieved from `libinput list-devices | grep Device`, example:
```c
static const KeyboardRule kbrules[] = {
	{ "AT Translated Set 2 keyboard", { .options = "altwin:swap_alt_win,caps:swapescape" } },
};
```

### Download
- [2023-09-20](https://github.com/djpohly/dwl/compare/main...apprehensions:dwl:kbrules.patch)

### Authors
- [sewn](https://github.com/apprehensions)