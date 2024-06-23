### Description
This patch modifies the behavior when selecting tags so that selecting a tag will also enable any other tags that were previously visible.

For example:
1. Select tag 5, with mod+5
2. Toggle tag 8, with ctrl+mod+8
3. Select tag 1, with mod+1. Tags 5 and 8 should no longer be visible.
4. Select tag 5 again, with mod+5. Tag 8 should be visible since it was remembered.
5. Select tag 5 again, with mod_5. Selecting the already selected tag resets any remembered tags, so now tag 5 should be the only one visible.

### Download
- [git branch](https://codeberg.org/minego/dwl/src/branch/remembertags)
- [2024-03-27](https://codeberg.org/dwl/dwl-patches/raw/branch/main/patches/remembertags/remembertags.patch)

### Authors
- [minego](https://codeberg.org/minego)