{ pkgs, ... }:
{
  home-manager.users.baba = {
    imports = [
      ./waybar
      ./wlsunset
    ];

    xdg.configFile."rofi/sidestyle.rasi".source = ./sidestyle.rasi;

    services.mako = {
      enable = true;
      font = "Inter UI, Font Awesome 10";
      padding = "15,20";
      backgroundColor = "#281733F0";
      textColor = "#ebeafa";
      borderSize = 2;
      borderColor = "#a4a0e8";
      defaultTimeout = 5000;
      markup = true;
      format = "<b>%s</b>\\n\\n%b";
    };

    home.sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
      MOZ_USE_XINPUT2 = "1";
      SDL_VIDEODRIVER = "wayland";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      XDG_CURRENT_DESKTOP = "niri";
    };

    home.packages = with pkgs; [
      swaylock
      swayidle
      xwayland
      rofi-wayland
      libinput-gestures
      qt5.qtwayland
      libnotify
      mako
      wl-clipboard
      waybar
      grim
      slurp
      niri
      pulseaudio
      playerctl
    ];

    xdg.configFile."niri/config.kdl".source = ./niri.kdl;
  };
}
