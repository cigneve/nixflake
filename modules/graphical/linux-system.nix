{ pkgs, lib, config, flakeModules, ... }:
let
  cfg = config.graphical_linux;
in
{
  imports = [
    ./pipewire.nix
    flakeModules.develop.base
    ./im
    ./plasma
    ./misc/media
  ];

  options = {
    graphical_linux.enable = lib.mkEnableOption "Enable linux specific settings in graphical module";
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.overlays = [
      # nixpkgs-wayland.overlay
    ];

    hardware.graphics.enable = true;

    security.polkit.enable = true;

    boot = {
      tmp.useTmpfs = true;
      kernel.sysctl."kernel.sysrq" = 1;
    };

    users.users.baba.packages = with pkgs; [
      v4l-utils
    ];

    environment.sessionVariables.NIXOS_OZONE_WL = "1";

    virtualisation.waydroid.enable = true;

    environment.systemPackages = with pkgs; [
      evince
      imv
      wl-clipboard
      dragon-drop
      pop-gtk-theme
      glib
      paper-icon-theme
      firefox
      chromium
      qutebrowser
      polkit
      polkit_gnome
      wf-recorder
      ffmpeg
      scrcpy
      android-tools
      anki
    ];

    fonts =
      let
        personalFonts = {
          monospace = "Comic Code Medium";
          serifAlias = "Cambria";
          serif = "Sprat";
          sans = "Avenir Next LT Pro";
        };
      in
      {
        packages = with pkgs; [
          ubuntu-classic
          font-awesome
          noto-fonts
          noto-fonts-cjk-sans
          twemoji-color-font
          inter
          fira-code-symbols
          fira-mono
          fira
          libertine
          roboto
          proggy
          cozette
        ];
        fontconfig.defaultFonts = {
          serif = [ personalFonts.serifAlias ];
          sansSerif = [ personalFonts.sans ];
          monospace = [ personalFonts.monospace ];
        };
        fontconfig.localConf = ''
          <fontconfig>
            <match>
              <test name="family"><string>Helvetica</string></test>
              <edit name="family" mode="assign" binding="strong">
                <string>Inter</string>
              </edit>
            </match>

          </fontconfig>
        '';
      };
  };
}
