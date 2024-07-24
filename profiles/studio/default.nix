{
  pkgs,
  lib,
  ...
}: {
  imports = [./daw.nix ./audio ./video.nix];
}
