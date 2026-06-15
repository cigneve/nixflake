{
  cig,
  pkgs,
  lib,
  ...
}: {
  cig.editors._.helix = {
    homeManager = {
      programs.helix.enable = true;
      xdg.configFile."helix/themes".source = ./themes;
      xdg.configFile."helix/config.toml".source = ./config.toml;
      xdg.configFile."helix/languages.toml".source = ./languages.toml;
    };
  };
}
