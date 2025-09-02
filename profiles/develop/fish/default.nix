{
  pkgs,
  lib,
  ...
}: {
  users = if pkgs.stdenv.isLinux then {
    defaultUserShell = pkgs.fish;
  } else {
    users.baba.shell = pkgs.fish;
  };

  environment.pathsToLink = ["/share/fish"];
  programs.fish.enable = true;

  environment = {
    systemPackages = with pkgs; [
    ];
  };
  home-manager.users.baba = {
    # xdg.configFile."fish".source = ./.;
    xdg.configFile."fish/functions".source = ./functions;
    # package = [pkgs.fishPlugins.autopair];
    programs.fish = {
      enable = lib.mkForce true;
      plugins = [
        {
          name = "autopair";
          src = pkgs.fishPlugins.autopair.src;
        }
        {
          name = "fzf";
          src = pkgs.fishPlugins.fzf-fish.src;
        }
      ];
      shellInit = builtins.readFile ./config.fish;

      shellAbbrs = {
      };
    };
  };
}

