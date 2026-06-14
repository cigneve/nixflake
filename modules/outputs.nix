{ inputs, config, ... }:
let
  nixosLib = inputs.nixos.lib;
  systems = [
    "x86_64-linux"
    "aarch64-darwin"
  ];

  forEachSystem = nixosLib.genAttrs systems;

  pkgsFor = nixpkgs: overlays: system:
    import nixpkgs {
      inherit system overlays;
      config.allowUnfree = true;
    };

  overlay = import ../pkgs inputs;

  pkgs' = pkgsFor inputs.nixos [ overlay ];

  mkSystemForOs = extraModules: systemFunc: pkgs: system: hostName:
    let
      osPkgs = pkgsFor pkgs [ overlay inputs.vsc-extensions.overlays.default ] system;
    in
    systemFunc {
      inherit system;

      specialArgs = {
        inherit inputs;
        flakeModules = config.flake.nixosModules or { };
      };

      modules =
        let
          homeManagerModule = inputs.home.nixosModules.home-manager;
          wslModule = inputs.nixos-wsl.nixosModules.wsl;

          global = {
            networking.hostName = hostName;
            nix.nixPath =
              let
                path = toString ../.;
              in
              [
                "nixpkgs=${inputs.nixpkgs}"
                "nixos=${inputs.nixos}"
                "nixos-config=${path}/configuration.nix"
                "home-manager=${inputs.home}"
              ];

            nixpkgs.pkgs = osPkgs;

            nixpkgs.flake.setNixPath = false;
            nixpkgs.flake.setFlakeRegistry = false;

            nix.registry = {
              nixpkgs.flake = inputs.nixpkgs;
              snowflake.flake = inputs.self;
              nixos.flake = inputs.nixos;
              home-manager.flake = inputs.home;
            };

            system.configurationRevision = nixosLib.mkIf (inputs.self ? rev) inputs.self.rev;
          };

          hostConfiguration = import ../hosts/${hostName};
        in
        [
          global
          hostConfiguration
        ]
        ++ (
          if osPkgs.stdenv.isLinux then
            [
              wslModule
              homeManagerModule
              inputs.disko.nixosModules.disko
              inputs.musnix.nixosModules.musnix
              inputs.quadlet-nix.nixosModules.quadlet
              {
                home-manager.sharedModules = [
                  inputs.plasma-manager.homeManagerModules.plasma-manager
                  inputs.quadlet-nix.homeManagerModules.quadlet
                ];
              }
              inputs.sops-nix.nixosModules.sops
            ]
          else
            [ inputs.home.darwinModules.home-manager ]
        )
        ++ extraModules;
    };

  mkSystem = mkSystemForOs [ config.flake.nixosModules.core.base ] inputs.nixpkgs.lib.nixosSystem;
  linuxSystem = "x86_64-linux";
in
{
  systems = systems;

  flake = {
    nixosConfigurations = {
      babadir = mkSystem inputs.nixos linuxSystem "babadir";
      iso = mkSystem inputs.nixos linuxSystem "iso";
      wsl = mkSystem inputs.nixos linuxSystem "wsl";
      t480 = mkSystem inputs.nixos linuxSystem "t480";
      elitedesk = mkSystem inputs.nixos linuxSystem "elitedesk";
      vm = mkSystem inputs.nixos "aarch64-linux" "vm";
    };

    darwinConfigurations = {
      mba = mkSystemForOs [] inputs.darwin.lib.darwinSystem inputs.nixos "aarch64-darwin" "mba";
    };

    nixosModules = { };

    overlay = overlay;
  };

  perSystem = system: {
    devShells.default = import ../shell.nix { pkgs = pkgs' system; };
    formatter = inputs.nixpkgs.legacyPackages.${system}.alejandra;
  };
}
