{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./pipewire.nix
    ../develop
    ./im
    ./plasma
  ];

  nixpkgs.overlays = [
    #nixpkgs-wayland.overlay
  ];

  hardware.graphics.enable = true;
  # For Vulkan
  # hardware.opengl.driSupport = true;

  security.polkit.enable = true;

  # TODO: cleanup, is Necessary?
  # systemd = {
  #   user.services."polkit-gnome-authentication-agent-1" = {
  #     description = "polkit-gnome-authentication-agent-1";
  #     wantedBy = [ "graphical-session.target" ];
  #     wants = [ "graphical-session.target" ];
  #     after = [ "graphical-session.target" ];
  #     serviceConfig = {
  #         Type = "simple";
  #         ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
  #         Restart = "on-failure";
  #         RestartSec = 1;
  #         TimeoutStopSec = 10;
  #       };
  #   };
  #    extraConfig = ''
  #      DefaultTimeoutStopSec=10s
  #    '';
  # };

  boot = {
    tmp.useTmpfs = true;

    kernel.sysctl."kernel.sysrq" = 1;
  };

  users.users.baba.packages = with pkgs; [
    v4l-utils
  ];

  home-manager.users.baba = {
    imports = [./misc/mpv];

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
        package = pkgs.libsForQt5.breeze-qt5;
      };
    };

    # TODO: Cleanup, is necessary?
    # gtk = pkgs.lib.mkDefault {
    #   enable = true;
    #   font.name = "Roboto 10";
    #   theme = {
    #     name = "Adwaita-dark";
    #     package = pkgs.gnome-themes-extra;      };
    #   iconTheme = {
    #     package = pkgs.paper-icon-theme;
    #     name = "Paper";
    #   };

    #   gtk3.extraConfig = {
    #     Settings = ''
    #       gtk-application-prefer-dark-theme=1
    #     '';
    #   };

    #   gtk4.extraConfig = {
    #     Settings = ''
    #       gtk-application-prefer-dark-theme=1
    #     '';
    #   };
    #   # TODO: gtk-cursor-theme-name..
    # };

    # home.file.".gtkrc-2.0".force = pkgs.lib.mkForce true;

    # Wayland support in electron-based apps
    xdg.configFile."electron-flags.conf".text = ''
      --enable-features=UseOzonePlatform
      --ozone-platform=wayland
    '';
  };

  # Wayland support
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  virtualisation.waydroid.enable = true;

  environment.systemPackages = with pkgs; [
    evince
    imv
    wl-clipboard
    xdragon
    # adapta-gtk-theme
    # cursor
    # dzen2
    # feh
    # ffmpeg-full
    # gnome3.adwaita-icon-theme
    # imagemagick
    # imlib2
    # librsvg
    # libsForQt5.qtstyleplugins
    # manpages
    pop-gtk-theme
    # nwg-look
    glib
    paper-icon-theme
    firefox-wayland
    chromium
    qutebrowser
    polkit
    polkit_gnome

    wf-recorder
    ffmpeg

    # logseq # TODO: wait for electron upgrade
    anki
    # calibre

    # qt5.qtgraphicaleffects
    # stdmanpages
    # zathura
  ];

  fonts = {
    packages = with pkgs; [
      font-awesome # waybar icons: TODO: move to there
      noto-fonts
      noto-fonts-cjk
      twemoji-color-font
      inter
      fira-code
      fira-code-symbols
      fira-mono
      cascadia-code
      fira
      libertine
      roboto
      # proggyfonts
      proggy
      cozette
    ];
    fontconfig.defaultFonts = {
      serif = ["Linux Libertine"];
      sansSerif = ["Inter"];
      monospace = ["Fira Code"];
    };
    # Bind Inter to Helvetica
    fontconfig.localConf = ''
      <fontconfig>
        <match>
          <test name="family"><string>Helvetica</string></test>
          <edit name="family" mode="assign" binding="strong">
            <string>Inter</string>
          </edit>
        </match>

        <match target="pattern">
          <test name="family" qual="any">
            <string>monospace</string>
          </test>
          <edit binding="strong" mode="prepend" name="family">
            <string>Cascadia Code</string>
          </edit>
        </match>
      </fontconfig>
    '';
  };
}
