{ ... }:
{
  flake.nixosModules.core = {
    base = import ../features/core/default.nix;
    linux = import ../features/core/linux.nix;
  };
}
