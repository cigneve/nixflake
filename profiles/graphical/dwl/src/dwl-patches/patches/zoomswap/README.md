### Description
This patch swaps the current window (C) with the previous master (P) when zooming.
```
Original behaviour :
+-----------------+-------+
|                 |       |
|                 |       |
|                 |       |
|        P        +-------|
|                 |       |
|                 |   C   |
|                 |       |
+-----------------+-------+

+-----------------+-------+
|                 |       |
|                 |   P   |
|                 |       |
|        C        +-------|
|                 |       |
|                 |       |
|                 |       |
+-----------------+-------+

New Behaviour :
+-----------------+-------+
|                 |       |
|                 |       |
|                 |       |
|        C        +-------+
|                 |       |
|                 |   P   |
|                 |       |
+-----------------+-------+

+-----------------+-------+
|                 |       |
|                 |       |
|                 |       |
|        P        +-------+
|                 |       |
|                 |   C   |
|                 |       |
+-----------------+-------+
```

### Download
- [git branch](https://codeberg.org/Palanix/dwl/src/branch/zoomswap)
- [2024-02-15](https://codeberg.org/dwl/dwl-patches/raw/branch/main/patches/zoomswap/zoomswap.patch)

### Authors
- [Palanix](https://codeberg.org/Palanix)
