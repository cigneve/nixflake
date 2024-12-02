{
  description = "Example flake";

  inputs = {
    cigneve.url = "github:cigneve/nixflake";
    nixpkgs.follows = "cigneve/nixpkgs";
  };

  outputs = {
    nixpkgs,
    ...
  }: let
    inherit (nixpkgs) lib;
    systems = [
      "x86_64-linux"
    ];
    forEachSystem = lib.genAttrs systems;
  in {
    devShells = forEachSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      default = pkgs.mkShell {

        NIX_LD_LIBRARY_PATH = lib.makeLibraryPath (with pkgs;[
          stdenv.cc.cc
          openssl
          libevdev
          # ...
        ]);

        nativeBuildInputs = with pkgs; [
          (pkgs.writeShellScriptBin "nix-lded" "export LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH\nexec \"$@\"")
        ];
      };
    });
  };
}
