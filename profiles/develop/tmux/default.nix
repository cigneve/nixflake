{
  lib,
  pkgs,
  ...
}:
{
  # environment.shellAliases = { tx = "tmux new-session -A -s $USER"; };

  programs.tmux = 
  let
    tpm = pkgs.tmuxPlugins.mkTmuxPlugin {
      pluginName = "tpm";
      version = "99469c";
      src = pkgs.fetchFromGitHub {
        repo  = "tpm";
        owner = "tmux-plugins";
        rev = "99469c4a9b1ccf77fade25842dc7bafbc8ce9946";
        sha256 = "sha256-hW8mfwB8F9ZkTQ72WQp/1fy8KL1IIYMZBtZYIwZdMQc=";
      };
    };
  in
  {
    enable = true;
    # sensible defaults
    sensibleOnTop = true;

    # set by tmux-sensible but the config resets it
    escapeTime = 0;
    historyLimit = 10000;
    aggressiveResize = true;
    # terminal = "tmux-256color";
    # focus-events

    # TODO: doesn't work because it tries binding C-`
    # shortcut = "`";

    # start window and pane numbers at 1
    baseIndex = 1;

    clock24 = true;

    customPaneNavigationAndResize = false; # use own mappings
    # disableConfirmationPrompt = true;

    # Use vi style keys
    keyMode = "vi";

    # Installing tpm manually
    extraConfig = ''
      ${builtins.readFile ./tmux.conf}
      run-shell ${tpm}/share/tmux-plugins/tpm/tpm
    '';
    # ${pluginConf plugins}
  };
}
