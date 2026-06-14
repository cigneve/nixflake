{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    capitaine-cursors
  ];

  programs.dconf.enable = true;

  xdg.portal.config.common.default = "*";
  xdg.portal.enable = true;
  xdg.portal.wlr.enable = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-gtk
    pkgs.xdg-desktop-portal-gnome
  ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  users.users.baba.packages = [ pkgs.swaybg ];
}
