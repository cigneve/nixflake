{
  pkgs,
  inputs,
  ...
}: {
  programs.vscode = {
    enable = true;
    profiles = {
      default = {extensions = with inputs.code-extensions.extensions; [];};
      go = {};
      java = {};
      python = {};
      rust = {};
      writing = {};
    };
  };
}
