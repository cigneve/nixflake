### Description
Dynamically adjusts the borders between adjacent windows to make them visually merge

**NOTE:** to disable minimalborders after applying this patch, set `draw_minimal_borders` to `0` 

```c
static const int draw_minimal_borders = 0; /* disable minimalborders */
```

<details>
<summary>Preview:</summary>
<pre>
with:

```c
static const unsigned int borderpx         = 10;  /* border pixel of windows */
```

Before applying the patch
<img src="https://i.imgur.com/VQfXCjp.png"/>

After applying the patch
<img src="https://i.imgur.com/I7s0Xkv.png"/>
</pre>
</details>

### Download
- [git branch](https://codeberg.org/wochap/dwl/src/branch/v0.5/minimalborders)
- [2024-04-11](https://codeberg.org/dwl/dwl-patches/raw/commit/7a5c3420822074c544fa102e030b7c30aa6b6be8/minimalborders/minimalborders.patch)
- [v0.5](https://codeberg.org/dwl/dwl-patches/raw/commit/be3735bc6a5c64ff76c200a8679453bd179be456/minimalborders/minimalborders.patch)

### Authors
- [wochap](https://codeberg.org/wochap)
