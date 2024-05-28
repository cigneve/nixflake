{pkgs,
...}: {
  users.defaultUserShell = pkgs.fish;

  environment.pathsToLink = ["/share/fish"];

  environment = {

    systemPackages = with pkgs; [
    ];
  };
  home-manager.users.babadir = {
    programs.fish = {
      enable = true;
      plugins = with pkgs.fishPlugins; [ fishplugin-autopair ];

      xdg.configFile."fish".source = ./.;

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
