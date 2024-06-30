{
  description = "Flake for my dwl fork";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    let
      inherit (nixpkgs) lib;

      systems = [
        "x86_64-linux"
      ];

      forEachSystem = lib.genAttrs systems;

      stdenv = system:
        let 
          pkgs = nixpkgs.legacyPackages.${system};
        in
          if pkgs.stdenv.isLinux
          then pkgs.stdenv
          else pkgs.clangStdenv;

      dwl-src = builtins.path {
        name = "dwl-custom";
        path = ./src;
      };

      defaultDeps = system: with nixpkgs.legacyPackages.${system};[
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
      packages = forEachSystem (system: 
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        dwl-custom = pkgs.stdenv.mkDerivation ({
          pname = "dwl-custom";
          version = "0.4";
          src = dwl-src;

          packages = defaultDeps system;

          nativeBuildInputs = defaultDeps system;

          buildinputs = defaultDeps system;

          outputs = [
            "out"
            "man"
          ];

          makeFlags = [
            "PKG_CONFIG=${pkgs.stdenv.cc.targetPrefix}pkg-config"
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
      });

      nixosModules = {
        dwl-custom = {lib,config,pkgs,...}:
        with lib;
        let
          cfg = config.programs.dwl-custom;
        in
        {
          options.programs.dwl-custom = {
            enable = mkEnableOption "dwl fork";
          };

          config = mkIf cfg.enable {

            environment.systemPackages = with pkgs; [
              capitaine-cursors
            ];

            # Apparently required for GTK3 settings on sway
            programs.dconf.enable = true;

            xdg.portal.config.common.default = "*"; 
            xdg.portal.enable = true;
            xdg.portal.wlr.enable = true;
            xdg.portal.extraPortals = [
              # Default portal
              pkgs.xdg-desktop-portal-gtk
              # Screencasting support
              pkgs.xdg-desktop-portal-gnome
            ];

          };

        };
      };

      devShells = forEachSystem (system: 
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      { 
        default = pkgs.mkShell {

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
      });
    };
}
