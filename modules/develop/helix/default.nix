{
  pkgs,
  lib,
  ...
}: {
  programs.helix.enable = true;
  xdg.configFile."helix/themes".source = ./themes;
  xdg.configFile."helix/config.toml".source = ./config.toml;
  xdg.configFile."helix/languages.toml".source = ./languages.toml;
}
