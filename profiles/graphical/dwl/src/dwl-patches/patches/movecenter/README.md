### Description
This patch provides a keybinding to center the focused floating window.

Press <kbd>MODKEY</kbd> + <kbd>x</kbd> to center the focused floating window.

It does NOT center windows that are not floating.

The variable `center_relative_to_monitor` allows the user to choose whether to center relative to the monitor or relative to the window area.

<details>
<summary>Explanation of center_relative_to_monitor:</summary>
<pre>
The "Monitor area" refers to the space enclosed by the green rectangle, while the "Window area" refers to the space enclosed by the red rectangle.
<img src="https://i.imgur.com/xhejzPh.png"/>
</pre>
</details>


### Download
- [git branch](https://codeberg.org/wochap/dwl/src/branch/v0.5/movecenter)
- [v0.5](https://codeberg.org/dwl/dwl-patches/raw/branch/main/patches/movecenter/movecenter.patch)

### Authors
- [wochap](https://codeberg.org/wochap)
