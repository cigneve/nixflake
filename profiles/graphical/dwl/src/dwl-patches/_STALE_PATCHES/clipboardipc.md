### Description
Adds clipboard functionality. Requires the [ipc](https://github.com/djpohly/dwl/wiki/ipc) patch for dwl and `wl-clipboard` to be installed. By default, requires [clipman](https://github.com/yory8/clipman) for the clipboard and [dwl-state](https://github.com/MadcowOG/dwl-state) for getting the appid of the focused application, but you can change these in the script if you have alternatives. You may change which applications to not record by modifying the `excludes` array in `dwl-cliboard-watcher`. Make sure `wl-paste -t text -w dwl-clipboard-watcher` is running after dwl.

### Downloads
 - [2023-3-01](https://github.com/djpohly/dwl/compare/main...MadcowOG:ipc-clipboard.patch)

### Authors
 - [MadcowOG](https://github.com/MadcowOG)