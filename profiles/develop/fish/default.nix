{
  pkgs,
  lib,
  ...
}: {
  users.defaultUserShell = pkgs.fish;

  environment.pathsToLink = ["/share/fish"];
  programs.fish.enable = true;

  environment = {
    systemPackages = with pkgs; [
    ];
  };
  home-manager.users.baba = {
    # xdg.configFile."fish".source = ./.;
    # xdg.configFile."fish/functions".source = ./functions;
    # package = [pkgs.fishPlugins.autopair];
    programs.fish = {
      enable = lib.mkForce true;
      plugins = [
        {
          name = "autopair";
          src = pkgs.fishPlugins.autopair;
        }
      ];
      shellInit = builtins.readFile ./config.fish;

      shellAbbrs = {
      };
    };
  };
}
