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
      profiles = let
        default_extensions = with pkgs.vscode-marketplace; [
          gregoire.dance
          dance_helix_ext
          mhutchie.git-graph
          usernamehw.errorlens
          mkhl.direnv
          jnoortheen.nix-ide
          arrterian.nix-env-selector
          quicktype.quicktype
          robbowen.synthwave-vscode
          myriad-dreamin.tinymist
          vivaxy.vscode-conventional-commits
          jjk.jjk
          github.copilot
          pkgs.vscode-marketplace-release.github.copilot-chat
          alefragnani.project-manager
        ];
      in {
        default = {
          enableUpdateCheck = false;
          extensions = default_extensions;
          userSettings = {
            "update.showReleaseNotes" = false;
            "explorer.excludeGitIgnore" = true;
            "zenMode.centerLayout" = true;
          };
        };
        rust = {
          extensions = with pkgs.vscode-marketplace;
            [
              rust-lang.rust-analyzer
            ]
            ++ default_extensions;
        };
        python = {
          extensions = with pkgs.vscode-marketplace;
            [
              ms-python.python
              ms-python.debugpy
              ms-python.black-formatter
              ms-python.vscode-python-envs
            ]
            ++ default_extensions;
        };
        go = {
          extensions = with pkgs.vscode-marketplace;
            [
              golang.go
            ]
            ++ default_extensions;
        };
        beancount = {
          extensions = with pkgs.vscode-marketplace;
            [
              lencerf.beancount
            ]
            ++ default_extensions;
        };
        swift = {
          extensions = with pkgs.vscode-marketplace;
            [
              swiftlang.swift-vscode
              llvm-vs-code-extensions.lldb-dap
            ]
            ++ default_extensions;
        };
        java = {
          extensions = with pkgs.vscode-marketplace;
            [
              redhat.java
              vscjava.vscode-java-debug
            ]
            ++ default_extensions;
        };
      };
    };
  };
}
