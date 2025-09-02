{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ../develop
    # ./im
    ./misc/media
  ];
  config = {

    home-manager.users.baba = {
      imports = [./misc/mpv];
    };

    environment.systemPackages = with pkgs; [
      # firefox-wayland
      firefox
      # chromium
      # qutebrowser

      # wf-recorder
      ffmpeg

      scrcpy
      android-tools

      # logseq # TODO: wait for electron upgrade
      # anki
      # calibre

      # qt5.qtgraphicaleffects
      # stdmanpages
      # zathura
    ];

    fonts = {
      packages = with pkgs; [
        ubuntu_font_family
        font-awesome # waybar icons: TODO: move to there
        noto-fonts
        noto-fonts-cjk-sans
        twemoji-color-font
        inter
        fira-code-symbols
        fira-mono
        # TODO: add these again
        # nerd-fonts.cascadia-code
        # nerd-fonts.fira-code
        fira
        libertine
        roboto
        # proggyfonts
        # proggy
        # cozette
      ];
    };

    # VM
    # virtualisation.virtualbox.host.enable = true;
    # users.extraGroups.vboxusers.members = [ "baba" ];
  };
}
