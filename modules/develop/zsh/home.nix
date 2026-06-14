{ pkgs, ... }:
{
  home-manager.users.baba = {
    programs.zsh = {
      enable = true;
      autosuggestion.enable = true;
      enableCompletion = false;
      defaultKeymap = "viins";
      dotDir = ".config/zsh";
      initExtra = builtins.readFile ./zshrc;

      shellAliases = {
        v = "$EDITOR";
        c = "cargo";
        cat = "${pkgs.bat}/bin/bat";
        df = "df -h";
        du = "du -h";
        g = "${pkgs.git}/bin/git";
        e = "v $(fzf)";
        l = "eza -lahgF --group-directories-first";
        ll = "eza -F";
        exa = "exa";
        j = "z";
        open = "${pkgs.xdg-utils}/bin/xdg-open";
        ps = "${pkgs.procs}/bin/procs";
      };

      plugins = [
        {
          name = "zsh-completions";
          src = pkgs.zsh-completions;
          file = "share/zsh/site-functions/zsh-completions.plugin.zsh";
        }
        {
          name = "fast-syntax-highlighting";
          src = pkgs.zsh-fast-syntax-highlighting;
          file = "share/zsh/site-functions/zsh-fast-syntax-highlighting.plugin.zsh";
        }
      ];
    };

    xdg.configFile."zsh/config" = {
      source = ./config;
      recursive = true;
    };

    programs.fzf = {
      enable = true;
      defaultOptions = [ "--reverse" "--ansi" ];
      defaultCommand = "fd .";
      fileWidgetCommand = "fd .";
      changeDirWidgetCommand = "fd --type d . $HOME";
    };

    programs.atuin = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        workspace = true;
        update_check = false;
      };
    };

    programs.zoxide.enable = true;
  };
}
