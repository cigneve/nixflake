{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.vscode_module;
in {
  options = {
    vscode_module.enable = lib.mkEnableOption "personal vscode module";
  };

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      profiles = let
        default_extensions = with pkgs.vscode-marketplace; [
          gregoire.dance
          gregoire.dance-helix
          mhutchie.git-graph
          usernamehw.errorlens
          mkhl.direnv
          jnoortheen.nix-ide
          arrterian.nix-env-selector
          quicktype.quicktype          
          robbowen.synthwave-vscode
          myriad-dreamin.tinymist
        ];
      in {
        default = {
          enableUpdateCheck = false;
          extensions = default_extensions;
        };
        rust = {
          extensions = with pkgs.vscode-marketplace; [
            rust-lang.rust-analyzer
          ] ++ default_extensions;
        };
        python = {
          extensions = with pkgs.vscode-marketplace; [
            ms-python.python
            ms-python.debugpy
            ms-python.black-formatter
            ms-python.vscode-python-envs
          ] ++ default_extensions;
        };
        go = {
          extensions = with pkgs.vscode-marketplace; [
            golang.go
          ] ++ default_extensions;
        };
        beancount = {
          extensions = with pkgs.vscode-marketplace; [
            lencerf.beancount
          ] ++ default_extensions;
        };
      };
    };
  };
}
