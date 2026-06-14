{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.vscode_module;
  dance_unstable = pkgs.fetchgit {
    url = "https://github.com/71/dance.git";
    rev = "546d09c08f64eee6308bd199c0c1fa9ee0b21e72";
    hash = "sha256-+wU0tEfy0tvnZgBtAPrPCnBdlLkXLshEeq5f3LvMAPc=";
  };
  dance_helix_ext = pkgs.vscode-utils.buildVscodeExtension {
    name = "dance_helix";
    vscodeExtPublisher = "gregoire";
    vscodeExtName = "dance-helix";
    vscodeExtUniqueId = "gregoire.dance-helix";
    pname = "dance-helix";
    src = dance_unstable;
    setSourceRoot = "sourceRoot=$(echo dance*/extensions/helix)";
    version = "1.1.0";
  };
in {
  options = {
    vscode_module.enable = lib.mkEnableOption "personal vscode module";
  };

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      mutableExtensionsDir = true;
  };
  };
}
