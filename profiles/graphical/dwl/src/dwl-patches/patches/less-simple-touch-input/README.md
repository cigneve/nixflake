### Description
Adds touchscreen functionality.

This patch was based on the [simple-touch-input](https://codeberg.org/dwl/dwl-patches/wiki/simple-touch-input) but instead of emulating mouse movement, this now forwards the appropriate event notifications to clients.

KNOWN BUGS:
- Sometimes, the pointer moves to where the screen is pressed, but the button press doesn't occur until the screen is touched AGAIN. This means that if you touch to click button 'Q' on the screen (for instance), nothing happens; then you touch elsewhere on the screen and THEN button 'Q' registers a click. This is annoying, doesn't always happen, and I don't yet know how to fix it.

### Download
- [git branch](https://codeberg.org/minego/dwl/src/branch/touch)
- [2024-03-26](https://codeberg.org/dwl/dwl-patches/raw/branch/main/patches/less-simple-touch-input/less-simple-touch-input.patch)

### Authors
- [minego](https://codeberg.org/minego)
- [fauxmight](https://codeberg.org/fauxmight)
- [Unprex](https://github.com/Unprex)

### Changelog
- 2024-02-11 Corrected issue where motion events where not sending notifications for unfocused clients such as an on screen keyboard
- 2024-03-26 Rebased, and removed #ifdef's for the pointer constraints patch which has been merged into upstream
- 2024-03-28 Removed debug