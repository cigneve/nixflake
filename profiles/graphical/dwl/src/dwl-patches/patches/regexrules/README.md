### Description
Allows the use of regular expressions for window rules "app_id" and "title"

```c
static const Rule rules[] = {
    // ...
    { "kitty-htop",  NULL,  1 << 8,  0,  -1 },
    { "^kitty$",     NULL,  0,       0,  -1 },
    // ...
};
```

### Download
- [git branch](https://codeberg.org/wochap/dwl/src/branch/v0.5/regexrules)
- [2024-04-11](https://codeberg.org/dwl/dwl-patches/raw/commit/2a6560c167e5c9afc5598ac5431d23d90de8846c/regexrules/regexrules.patch)
- [v0.5](https://codeberg.org/dwl/dwl-patches/raw/commit/98cba933c9f4099202e54f39acbf17e05bde828a/regexrules/regexrules.patch)

### Authors
- [wochap](https://codeberg.org/wochap)
