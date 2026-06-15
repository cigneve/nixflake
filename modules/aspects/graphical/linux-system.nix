{
  pkgs,
  lib,
  config,
  flakeModules,
  ...
}: {
  cig.linuxSystem._.pipewire.nixos = {
    hardware.graphics.enable = true;

    security.polkit.enable = true;

    boot = {
      tmp.useTmpfs = true;
      kernel.sysctl."kernel.sysrq" = 1;
    };

    users.users.baba.packages = with pkgs; [
      v4l-utils
    ];

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
  };
}
