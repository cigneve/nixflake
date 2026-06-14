{ ... }:
{
  flake.nixosModules.darwin = {
    base = import ../features/darwin/default.nix;
    homebrew = import ../features/darwin/homebrew.nix;
  };
}
