{ ... }:
{
  flake.nixosModules.laptop = {
    base = import ../features/laptop/default.nix;
  };
}
