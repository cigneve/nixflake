{lib,pkgs,config,...}:let cfg = config.vscode_module; in {
  options = {
    vscode_module.enable = lib.mkEnableOption "Enable personal vscode module";
  };

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;
    };
  };
}
