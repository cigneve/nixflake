{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    capitaine-cursors
  ];

  programs.dconf.enable = true;

  programs.tmux.extraConfig = lib.mkBefore ''
    set -g @override_copy_command 'wl-copy'
  '';

  xdg.portal.config.common.default = "*";
  xdg.portal.enable = true;
  xdg.portal.wlr.enable = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
  ];
}
