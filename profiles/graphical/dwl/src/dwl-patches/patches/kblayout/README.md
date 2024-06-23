### Description
This patch adds per-client keyboard layout and ability to send current
keyboard layout information to a status bar.

Only per-client feature is enabled by default. You can edit
`kblayout_file` and `kblayout_cmd` variables to notify a status bar
about keyboard layout.

[Someblocks](https://sr.ht/~raphi/someblocks) config that works
with the example settings in `config.h`:

```c
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{"", "cat /tmp/dwl-kblayout",					0,		1},
};
```

Both of these features are included in one patch because their
implementation happens to share some code. If you don't need
any of these features, just disable it in `config.h`.

### Download
- [2024-06-01](https://codeberg.org/dwl/dwl-patches/raw/branch/main/patches/kblayout/kblayout.patch)

### Authors
- [ForzCross](https://codeberg.org/ForzCross)
- [Nikita Ivanov](https://github.com/NikitaIvanovV)
