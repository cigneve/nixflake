### Description
Adds 2 more borders to each side (top, bottom, left, right) of every window.



<details>
<summary>Preview</summary>
<pre>
With the following config:

```c
static const unsigned int borderpx         = 9;  /* border pixel of windows */
static const unsigned int borderspx        = 3;  /* width of the border that start from outside the windows */
static const unsigned int borderepx        = 3;  /* width of the border that start from inside the windows */
```

and `border_color_type` set to `BrdOriginal`:
<img src="https://i.imgur.com/msead2K.png"/>

and `border_color_type` set to `BrdStart`:
<img src="https://i.imgur.com/ssgPG36.png"/>

and `border_color_type` set to `BrdEnd`:
<img src="https://i.imgur.com/i2Xtjy6.png"/>

and `border_color_type` set to `BrdStartEnd`:
<img src="https://i.imgur.com/fnkitdR.png"/>
</pre>
</details>

### Download
- [git branch](https://codeberg.org/wochap/dwl/src/branch/v0.5/borders)
- [v0.5](https://codeberg.org/dwl/dwl-patches/raw/branch/main/patches/borders/borders.patch)

### Authors
- [wochap](https://codeberg.org/wochap)
