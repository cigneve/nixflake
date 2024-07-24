{
  config,
  pkgs,
  lib,
  ...
}: let
  dwl-patches = pkgs.fetchgit {
    url = "https://codeberg.org/dwl/dwl-patches.git";
    # hash = "";
    hash = "sha256-UILLT2SDsojUjFBlxszER9Jyw8DIeaATOOcvG5Ktco0=";
  };
in {
  environment.systemPackages = with pkgs; [dwl];
  nixpkgs.overlays = [
    (final: prev: {
      dwl = prev.dwl.overrideAttrs {
        patches = [
          # "${dwl-patches}/patches/swallow/swallow.patch"
          "${dwl-patches}/patches/focusdir/focusdir.patch"
          "${dwl-patches}/patches/vanitygaps/vanitygaps.patch"
          "${dwl-patches}/patches/autostart/autostart.patch"
          "${dwl-patches}/patches/ipc/ipc.patch"
          "${dwl-patches}/patches/modes/modes.patch"
          "${dwl-patches}/patches/pertag/pertag.patch"
          "${dwl-patches}/patches/monfig/monfig.patch"
          "${dwl-patches}/patches/unclutter/unclutter.patch"
          "${dwl-patches}/patches/togglekblayoutandoptions/togglekblayoutandoptions.patch"
          "${dwl-patches}/patches/regexrules/regexrules.patch"
          "${dwl-patches}/patches/xwayland-handle-minimize/xwayland-handle-minimize.patch"
        ];
      };
    })
  ];
}
