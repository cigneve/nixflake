{ pkgs, ... }:
{
  users.defaultUserShell = pkgs.zsh;

  environment.pathsToLink = [ "/share/zsh" ];
  programs.zsh.enable = true;

  environment = {
    sessionVariables = { };

    systemPackages = with pkgs; [
      bat
      bzip2
      eza
      fd
      fzf
      gzip
      lrzip
      p7zip
      procs
      skim
      unzip
      xz
      xdg-utils
    ];
  };
}
