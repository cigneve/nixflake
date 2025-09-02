{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.mpv = {
    enable = true;
    scripts = with pkgs.mpvScripts; [
      # mpris
      autoload
    ];
  };

  xdg.configFile."mpv/mpv.conf".source = ./mpv.conf;
  xdg.configFile."mpv/input.conf".source = ./input.conf;
  xdg.configFile."mpv/shaders/".source = ./shaders;
}
