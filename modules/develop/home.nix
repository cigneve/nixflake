{ pkgs, ... }:
{
  home-manager.users.baba = {
    imports = [
      ./fish/home.nix
      ./helix
      ./terminal
      ./tmux
      ./yazi
      ./vscode.nix
    ];

    vscode_module.enable = true;

    home.packages = with pkgs; [ vscode ];

    programs.fzf = {
      enable = true;
      defaultOptions = [ "--reverse" "--ansi" ];
      defaultCommand = "fd .";
      fileWidgetCommand = "fd .";
      changeDirWidgetCommand = "fd --type d . $HOME";
    };

    programs.atuin = {
      settings = {
        workspace = true;
        update_check = false;
      };
    };

    programs.zoxide = {
      enable = true;
    };
  };
}
