{cig, ...}: {
  cig.shells._.fish = {
    homeManager = {
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
        shellAbbrs = {};
      };
      nixos = {
        programs.fish.enable = true;
      };
      darwin = {
        programs.fish.enable = true;
      };
    };
  };
}
