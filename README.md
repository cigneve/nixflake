<h4 align="center"> Nix flakes</h4>

Forked from <https://github.com/archseer/snowflake>

NixOS configurations for **wsl**, **vm**, and **Zephyrus G14**.

# Setup

```
# Usage: rebuild host {switch|boot|test|iso}
rebuild <host-filename> test
```

## Build an ISO

You can make an ISO and customize it by modifying the [iso](./hosts/iso.nix)
file:

```sh
rebuild iso
```

# License

This software is licensed under the [MIT License](COPYING).

Note: MIT license does not apply to the packages built by this configuration,
merely to the files in this repository (the Nix expressions, build
scripts, NixOS modules, etc.). It also might not apply to patches
included here, which may be derivative works of the packages to
which they apply. The aforementioned artifacts are all covered by the
licenses of the respective packages.
