### Description
This patch is a modified version of [vanitygaps][vanitygaps] that adds gaps around clients regardless of a layout.
It means you can apply any layout patch and the gaps will be shown properly as long as the layout does not add any gaps on its own.

This works by allowing a layout to place clients normally without gaps,
and then correcting positions and dimensions of clients afterwards to add gaps around them.
To make it work, I had to modify `resize()` function,
and, as a side effect, this change fixed some flickering I experienced when using [snail][snail] layout.

[snail]: https://github.com/djpohly/dwl/wiki/snail
[vanitygaps]: https://github.com/djpohly/dwl/wiki/vanitygaps

### Changelog

2023-11-24:
- Refactor, it does exactly the same, just using less code.
- Replace `gappih`, `gappiv`, `gappoh` and `gappov` with only `gappx`. They don't do anything anyways.

### Download
- [2023-11-24](https://github.com/djpohly/dwl/compare/main...wochap:genericgaps.patch)
- [2023-05-20](https://github.com/djpohly/dwl/compare/main...NikitaIvanovV:genericgaps.patch) generic gaps
- [2023-05-20](https://github.com/djpohly/dwl/compare/main...NikitaIvanovV:genericgaps-rule.patch) generic gaps + monitor rule to enable gaps on certain monitors by default

### Authors
- [Nikita Ivanov](https://github.com/NikitaIvanovV)
