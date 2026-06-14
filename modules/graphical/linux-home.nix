{ config, lib, pkgs, ... }:
let
  cfg = config.graphical_linux;
in
{
  config = lib.mkIf cfg.enable {
    home-manager.users.baba = {
      imports = [ ./misc/mpv ];

      home.sessionVariables = {
        MOZ_ENABLE_WAYLAND = "1";
        MOZ_USE_XINPUT2 = "1";
        SDL_VIDEODRIVER = "wayland";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        _JAVA_AWT_WM_NONREPARENTING = "1";
      };

      dconf.settings = {
        "org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };
      };

      qt = {
        enable = true;
        platformTheme.name = "adwaita";
        style = {
          name = "Breeze";
          package = pkgs.kdePackages.breeze.qt5;
        };
      };

      xdg.configFile."electron-flags.conf".text = ''
        --enable-features=UseOzonePlatform
        --ozone-platform=wayland
      '';

      home.packages = with pkgs; [
        vscode
        mars-mips
      ];
    };
  };
}
