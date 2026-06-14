{ ... }:
{
  flake.nixosModules.develop = {
    base = import ../features/develop/default.nix;
    system = import ../features/develop/system.nix;
    home = import ../features/develop/home.nix;
    fish = import ../features/develop/fish/default.nix;
    zsh = import ../features/develop/zsh/default.nix;
    podman = import ../features/develop/podman/default.nix;
    terminal = import ../features/develop/terminal/default.nix;
    helix = import ../features/develop/helix/default.nix;
    neovim = import ../features/develop/neovim/default.nix;
    tmux = import ../features/develop/tmux/default.nix;
    yazi = import ../features/develop/yazi/default.nix;
    zellij = import ../features/develop/zellij/default.nix;
    alacritty = import ../features/develop/alacritty/default.nix;
    wezterm = import ../features/develop/wezterm/default.nix;
    vscode = import ../features/develop/vscode.nix;
  };
}
