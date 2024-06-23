### Description
This patch adds 3 additional options to the `Key` struct, `on_press`, `on_repeat` and `on_release` which can be used to control which events a key binding should be triggered on.

NOTE: Due to concerns about patching difficulties this patch does NOT include any changes to `config.def.h`. After applying you will need to add the 3 additional initializers to each key binding that you would like to modify. Any key binding that is not updated will cause a build warning but should function as it does in vanilla.

### Download
- [git branch](https://codeberg.org/USERNAME/dwl/src/branch/press_repeat_release)
- [2024-03-27](https://codeberg.org/dwl/dwl-patches/raw/branch/main/patches/press_repeat_release/press_repeat_release.patch)

### Authors
- [minego](https://codeberg.org/minego)