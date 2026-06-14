{ pkgs, ... }:
{
  users =
    if pkgs.stdenv.isLinux then
      { defaultUserShell = pkgs.fish; }
    else
      { users.baba.shell = pkgs.fish; };

  environment.pathsToLink = [ "/share/fish" ];
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [ ];
}
