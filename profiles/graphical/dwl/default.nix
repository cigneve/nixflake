{config,
pkgs,
lib,
...}:
  let
    dwl-patches = pkgs.fetchGit {
      url = "https://codeberg.org";
      ref = "main";
    };
  in
  {
  nixpkgs.overlays = [
    (final: prev: {
      dwl = prev.dwl.overrideAttrs {
        patches = [
          "${dwl-patches}/patches/focusdir/focusdir.patch"
          "${dwl-patches}/patches/swallow/swallow.patch"
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
  ]
  }
