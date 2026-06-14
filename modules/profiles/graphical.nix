{ ... }:
{
  flake.nixosModules.graphical = {
    base = import ../features/graphical/default.nix;
    linux = import ../features/graphical/linux.nix;
    pipewire = import ../features/graphical/pipewire.nix;
    plex = import ../features/graphical/plex.nix;
    im = import ../features/graphical/im/default.nix;
    plasma = import ../features/graphical/plasma/default.nix;
    hyprland = import ../features/graphical/hyprland/default.nix;
    niri = import ../features/graphical/niri/default.nix;
    sway = import ../features/graphical/sway/default.nix;
    waybar = import ../features/graphical/waybar/default.nix;
    wlsunset = import ../features/graphical/wlsunset/default.nix;
    mpv = import ../features/graphical/misc/mpv/default.nix;
    media = import ../features/graphical/misc/media/default.nix;
    zathura = import ../features/graphical/zathura/default.nix;
  };
}
