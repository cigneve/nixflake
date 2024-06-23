### Description
Allows for the creation of multiple scratchpad windows, each assigned to a different keybinding. In simple terms, it enables 'run or raise' functionality

This patch adds the following functions:
* `togglescratch`: simply toggles the scratchpad window 
* `focusortogglescratch`: change the focus to the scratchpad window if it is visible and toggles it if it is already in focus
* `focusortogglematchingscratch`: similar to `focusortogglescratch` but also closes all other scratchpad windows

### Download
- [git branch](https://codeberg.org/wochap/dwl/src/branch/v0.5/namedscratchpads)
- [v0.5](https://codeberg.org/dwl/dwl-patches/raw/branch/main/patches/namedscratchpads/namedscratchpads.patch)

### Authors
- [wochap](https://codeberg.org/wochap)
- [Louis-Michel Raynauld](https://github.com/loumray)
