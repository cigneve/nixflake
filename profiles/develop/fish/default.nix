{pkgs,
lib,
...}: {
  users.defaultUserShell = pkgs.fish;

  environment.pathsToLink = ["/share/fish"];
  programs.fish.enable = true;

  environment = {

    systemPackages = with pkgs; [
    ];
  };
  home-manager.users.baba = {
    xdg.configFile."fish".source = ./. ;
    # xdg.configFile."fish/fish_variables".source = ./fish_variables;
    # xdg.configFile."fish/functions".source = ./functions;
    programs.fish = {
      enable = lib.mkForce true;
      # plugins = with pkgs.fishPlugins; [ autopair ];


      shellAbbrs = {


        v = "$EDITOR";
        c = "cargo";

        cat = "${pkgs.bat}/bin/bat";

        df = "df -h";
        du = "du -h";

        g = "${pkgs.git}/bin/git";

        e = "v $(fzf)";

        l = "eza -lahgF --group-directories-first";
        # --time-style=long-iso
        ll = "eza -F";
        exa = "exa";

        # j stands for jump
        j = "z";

        open = "${pkgs.xdg-utils}/bin/xdg-open";
        ps = "${pkgs.procs}/bin/procs";
      };

    };


};
}
