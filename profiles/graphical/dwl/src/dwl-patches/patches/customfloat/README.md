### Description
Rules for floating windows support default x, y, width, height. Defaults to the center of the screen and the client size.

If the width or height is less than or equal to 1, then the value will be interpreted as a percentage. For example, 0.5 represents 50%, 0.25 represents 25%, and 1 represents 100%. **NOTE**: Some clients, like Thunar, have minimum width/height

The variable `center_relative_to_monitor` allows the user to choose whether to center relative to the monitor or relative to the window area.

<details>
<summary>Explanation of center_relative_to_monitor:</summary>
<pre>
The "Monitor area" refers to the space enclosed by the green rectangle, while the "Window area" refers to the space enclosed by the red rectangle.
<img src="https://i.imgur.com/xhejzPh.png"/>
</pre>
</details>

### Download
- [git branch](https://codeberg.org/wochap/dwl/src/branch/v0.5/customfloat)
- [2024-04-11](https://codeberg.org/dwl/dwl-patches/raw/commit/98cba933c9f4099202e54f39acbf17e05bde828a/customfloat/customfloat.patch)
- [v0.5](https://codeberg.org/dwl/dwl-patches/raw/commit/bf098459219e7a473d8edb4c0435aeb6a4b82e38/customfloat/customfloat.patch)

### Authors
- [wochap](https://codeberg.org/wochap)
- [Stivvo](https://github.com/Stivvo)
