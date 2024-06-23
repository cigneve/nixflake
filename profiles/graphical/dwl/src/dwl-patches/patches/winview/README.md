### Description
Implements the function `winview` which switches the visible tags to the tags on which the current client is visible.

This patch is inspired from <https://dwm.suckless.org/patches/winview/>. Citing the description of the dwm patch:

> Dwm tags are a powerfull feature that allows organizing windows in workspaces. Sometime it can be difficult to remember the tag to activate to unhide a window. With the winview patch the window to unhide can be selected from the all-window view. The user switches to the all-window view (Mod1-0), selects the window (Mod1-j/k or using the mouse) and press Mod1-o. The key Mod1-o switches the view to the selected window tag.
> 
> #### Recommend patches
> 
> The grid layout is well adapted to display many windows in a limited space. Using both grid and pertag patches you will be able to select this layout for the all-window view while keeping your preferred layout for the other views.
> Configuration and Installation
> Using the default configuration file
> 
>     Make sure the directory where you build dwm does not contain a config.h file;
>     Apply the patch;
>     Run make and make install.
> 
> Using an existing customised configuration file
> 
> Apply the patch; Add the following element in the keys array:
> 
> `{ MODKEY, XK_o, winview, {0} },`
> 
> Run make and make install.
> 
> An example of how to insert this line can be found in the default config file template, config.def.h.

### Download
- [2023-11-26](https://codeberg.org/dwl/dwl-patches/raw/branch/main/patches/winview/winview.patch)
- [git branch](https://codeberg.org/dhruva_sambrani/dwl/src/branch/winview)

### Authors
- [Dhruva Sambrani](https://codeberg.org/dhruva_sambrani)

