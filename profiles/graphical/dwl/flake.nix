{
  description = "Flake for my dwl fork";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    let
      inherit (nixpkgs) lib;

      systems = [
        "x86_64-linux"
      ];

      forEachSystem = lib.genAttrs systems;

      stdenv = system:
        let 
          pkgs = nixpkgs.legacyPackages.${system};
        in
          if pkgs.stdenv.isLinux
          then pkgs.stdenv
          else pkgs.clangStdenv;

      dwl-src = builtins.path {
        name = "dwl-custom";
        path = ./src;
      };

      defaultDeps = system: with nixpkgs.legacyPackages.${system};[
        gnumake
        pkg-config
        installShellFiles
        lynx
        libinput
        xorg.libxcb
        libxkbcommon
        pixman
        wayland
        wayland-protocols
        wlroots
        xorg.libX11
        xorg.xcbutilwm
        xwayland
        wayland-scanner
      ];
    in
    {
      packages = forEachSystem (system: 
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        dwl-custom = pkgs.stdenv.mkDerivation ({
          pname = "dwl-custom";
          version = "0.4";
          src = dwl-src;

          packages = defaultDeps system;

          nativeBuildInputs = defaultDeps system;

          buildinputs = defaultDeps system;

          outputs = [
            "out"
            "man"
          ];

          makeFlags = [
            "PKG_CONFIG=${pkgs.stdenv.cc.targetPrefix}pkg-config"
            "WAYLAND_SCANNER=wayland-scanner"
            "PREFIX=$(out)"
            "MANDIR=$(man)/share/man"
          ];

          buildPhase = ''
            make clean
            make
          '';

        meta = {
          description = "Dynamic window manager for Wayland";
          license = pkgs.lib.licenses.gpl3Only;
        };
        });

        default = self.packages.${system}.dwl-custom;
      });

      nixosModules = {
        dwl-custom = {lib,config,pkgs,...}:
        with lib;
        let
          cfg = config.programs.dwl-custom;
        in
        {
          options.programs.dwl-custom = {
            enable = mkEnableOption "dwl fork";
          };

          config = mkIf cfg.enable {

            environment.systemPackages = with pkgs; [
              self.packages."x86_64-linux".dwl-custom
              capitaine-cursors
            ];

            # Apparently required for GTK3 settings on sway
            programs.dconf.enable = true;

            xdg.portal.config.common.default = "*"; 
            xdg.portal.enable = true;
            xdg.portal.wlr.enable = true;
            xdg.portal.extraPortals = [
              # Default portal
              # pkgs.xdg-desktop-portal-gtk
              # Screencasting support
              # pkgs.xdg-desktop-portal-gnome
            ];

          };

        };
      };

      home-managerModules = {
        dwl-custom = {lib,config,pkgs,...}:
        with lib;
        let
          aksdokasod=5;
        in
        {

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
            XDG_CURRENT_DESKTOP = "dwl";

            GBM_BACKEND= "nvidia-drm";
            __GLX_VENDOR_LIBRARY_NAME= "nvidia";
            LIBVA_DRIVER_NAME= "nvidia"; # hardware acceleration
            __GL_VRR_ALLOWED="1";
            WLR_NO_HARDWARE_CURSORS = "1";
            WLR_RENDERER_ALLOW_SOFTWARE = "1";
            CLUTTER_BACKEND = "wayland";
            WLR_RENDERER = "vulkan";


          };

          home.packages = with pkgs; [
            hyprland

            swaylock
            swayidle
            xwayland

            rofi-wayland
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
            pulseaudio # just for pactl, wish there was pulseaudio-util
            playerctl
          ];

        };
        };

      devShells = forEachSystem (system: 
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      { 
        default = pkgs.mkShell {

          buildinputs = with pkgs; [
            libinput
            xorg.libxcb
            libxkbcommon
            pixman
            wayland
            wayland-protocols
            wlroots
            xorg.libX11
            xorg.xcbutilwm
            xwayland
            wayland-scanner
          ];

          nativeBuildInputs = with pkgs;[
            gnumake
            pkg-config
            installShellFiles
            lynx
            libinput
            xorg.libxcb
            libxkbcommon
            pixman
            wayland
            wayland-protocols
            wlroots
            xorg.libX11
            xorg.xcbutilwm
            xwayland
            wayland-scanner
          ];
        };
      });
    };
}
