{
  description = "Flake for my dwl fork";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
      };

      stdenv = 
        if pkgs.stdenv.isLinux
        then pkgs.stdenv
        else pkgs.clangStdenv;

      dwl-src = builtins.path {
        name = "dwl-custom";
        path = ./src;
      };

      defaultDeps = with pkgs;[
        gnumake
        pkg-config
        installShellFiles
        lynx
        libinput
        xorg.libxcb
        libxkbcommon
        pixman
        wayland
        wayland-protocols
        wlroots
        xorg.libX11
        xorg.xcbutilwm
        xwayland
        wayland-scanner
      ];
      in
      {
        packages = {
          dwl-custom = stdenv.mkDerivation ({
            pname = "dwl-custom";
            version = "0.4";
            src = dwl-src;

            packages = defaultDeps;

            nativeBuildInputs = defaultDeps;

            buildinputs = defaultDeps;

            outputs = [
              "out"
              "man"
            ];

            makeFlags = [
              "PKG_CONFIG=${stdenv.cc.targetPrefix}pkg-config"
              "WAYLAND_SCANNER=wayland-scanner"
              "PREFIX=$(out)"
              "MANDIR=$(man)/share/man"
            ];

            buildPhase = ''
              make clean
              make
            '';

          meta = {
            description = "Dynamic window manager for Wayland";
            license = pkgs.lib.licenses.gpl3Only;
          };
          });

          default = self.packages.${system}.dwl-custom;
        };

        devShells.default = pkgs.mkShell {

          buildinputs = with pkgs; [
            libinput
            xorg.libxcb
            libxkbcommon
            pixman
            wayland
            wayland-protocols
            wlroots
            xorg.libX11
            xorg.xcbutilwm
            xwayland
            wayland-scanner
          ];

          nativeBuildInputs = with pkgs;[
            gnumake
            pkg-config
            installShellFiles
            lynx
            libinput
            xorg.libxcb
            libxkbcommon
            pixman
            wayland
            wayland-protocols
            wlroots
            xorg.libX11
            xorg.xcbutilwm
            xwayland
            wayland-scanner
          ];
        };
      }
    );
}
