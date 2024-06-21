{pkgs,
lib,
...}: {
  programs.helix.enable = true;
  home-manager.users.baba = {
    xdg.configFile."helix/themes".source = ./themes ;
    xdg.configFile."helix/config.toml".source = ./config.toml;
};
}
