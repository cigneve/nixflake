### Description
This is a port of centeredmaster patch for dwm: <https://dwm.suckless.org/patches/centeredmaster>

centeredmaster centers the nmaster area on screen, using mfact * monitor
width & height, with the stacked windows distributed to the left and
right. It can be selected with `Alt+c`.

With one and two clients in master respectively this results in:

```
+------------------------------+       +------------------------------+
|+--------++--------++--------+|       |+--------++--------++--------+|
||        ||        ||        ||       ||        ||        ||        ||
||        ||        ||        ||       ||        ||   M1   ||        ||
||        ||        ||        ||       ||        ||        ||        ||
||  S2    ||   M    ||   S1   ||       ||        |+--------+|        ||
||        ||        ||        ||       ||        |+--------+|        ||
||        ||        ||        ||       ||        ||        ||        ||
||        ||        ||        ||       ||        ||   M2   ||        ||
||        ||        ||        ||       ||        ||        ||        ||
|+--------++--------++--------+|       |+--------++--------++--------+|
+------------------------------+       +------------------------------+
```


### Download
- [git branch](https://codeberg.org/wochap/dwl/src/branch/v0.5/centeredmaster)
- [2024-04-11](https://codeberg.org/dwl/dwl-patches/raw/commit/b104a580a80ebaf9f7e8917fe574e3e97ddd019a/centeredmaster/centeredmaster.patch)
- [v0.5](https://codeberg.org/dwl/dwl-patches/raw/commit/0f4e40fee49d1b8b430778e241b29496ae3b3b70/centeredmaster/centeredmaster.patch)

### Authors
- [wochap](https://codeberg.org/wochap)
- [Nikita Ivanov](https://github.com/NikitaIvanovV)
