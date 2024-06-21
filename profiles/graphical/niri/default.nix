{
  lib,
  pkgs,
  inputs,
  ...
}: let
  left = "h";
  down = "j";
  up = "k";
  right = "l";

  fonts = {
    names = ["Inter"];
    style = "Regular";
    size = 10.0;
  };

  menu = "${pkgs.rofi-wayland}/bin/rofi -terminal ${terminal} -show drun -theme sidestyle -show-icons -icon-theme Paper";


in {
  imports = [];

  environment.systemPackages = with pkgs; [
    capitaine-cursors
  ];

  # Apparently required for GTK3 settings on sway
  programs.dconf.enable = true;

  xdg.portal.config.common.default = "*"; 
  xdg.portal.enable = true;
  xdg.portal.wlr.enable = true;
  xdg.portal.extraPortals = [
    # Default portal
    pkgs.xdg-desktop-portal-gtk
    # Screencasting support
    pkgs.xdg-desktop-portal-gnome
    pkgs.gnome-keyring
  ];

  home-manager.users.baba = {pkgs, ...}: {
    imports = [./waybar ./wlsunset];

    # rofi menu style
    xdg.configFile."rofi/sidestyle.rasi".source = ./sidestyle.rasi;

    # Starts automatically via dbus
    services.mako = {
      enable = true;
      font = "Inter UI, Font Awesome 10";
      padding = "15,20";
      # backgroundColor = "#3b224cF0";
      backgroundColor = "#281733F0";
      textColor = "#ebeafa";
      borderSize = 2;
      borderColor = "#a4a0e8";
      defaultTimeout = 5000;
      markup = true;
      format = "<b>%s</b>\\n\\n%b";

      # TODO:
      # [hidden]
      # format=(and %h more)
      # text-color=#999999

      # [urgency=high]
      # text-color=#F22C86
      # border-color=#F22C86
      # border-size=4
    };

    home.sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
      MOZ_USE_XINPUT2 = "1";

      SDL_VIDEODRIVER = "wayland";
      # needs qt5.qtwayland in systemPackages
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      _JAVA_AWT_WM_NONREPARENTING = "1";

      # XDG_SESSION_TYPE = "wayland"; now set by wlroots https://github.com/nix-community/home-manager/commit/2464c21ab2b3607bed3c206a436855c487f35f55
      XDG_CURRENT_DESKTOP = "niri";
    };

    home.packages = with pkgs; [
      swaylock
      swayidle
      xwayland

      rofi-wayland
      #
      libinput-gestures
      qt5.qtwayland
      # alacritty
      libnotify
      mako
      # volnoti
      wl-clipboard
      waybar
      grim
      slurp
      # ydotool-git
      niri
      pulseaudio # just for pactl, wish there was pulseaudio-util
      playerctl
    ];

    xdg.configFile."niri/config.kdl".source = ./niri.kdl;
    
  };
}
