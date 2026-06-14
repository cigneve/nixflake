{ ... }:
{
  flake.nixosModules.ssh = {
    base = import ../features/ssh/default.nix;
  };
}
