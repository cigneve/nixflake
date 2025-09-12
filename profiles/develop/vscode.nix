{lib,pkgs,config,...}:let cfg = config.vscode_module; in {
  options = {
    vscode_module.enable = lib.mkEnableOption "personal vscode module";
  };

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      profiles = {
        default = {
          enableUpdateCheck = false;
          extensions = with pkgs.vscode-marketplace; [
            gregoire.dance
            mhutchie.git-graph
            usernamehw.errorlens
            mkhl.direnv
            jnoortheen.nix-ide
            arrterian.nix-env-selector
          ];
        };
        rust = {
          extensions = with pkgs.vscode-marketplace; [
            rust-lang.rust-analyzer
          ];
        };
        python = {
          extensions = with pkgs.vscode-marketplace; [
            ms-python.python

          ];
        };
      };
    };
  };
}
