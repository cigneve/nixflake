{ ... }:
{
  flake.nixosModules.studio = {
    base = import ../features/studio/default.nix;
    audio = import ../features/studio/audio/default.nix;
    daw = import ../features/studio/daw.nix;
    video = import ../features/studio/video.nix;
  };
}
