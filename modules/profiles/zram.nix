{ ... }:
{
  flake.nixosModules.zram = {
    base = import ../features/zram/default.nix;
  };
}
