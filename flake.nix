{
  description = "My personal config";

  inputs = {
    nixos.url = "nixpkgs/nixos-unstable";
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";

    home.url = "github:rycee/home-manager";
    home.inputs.nixpkgs.follows = "nixpkgs";

    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
    
    hardware.url = "github:NixOS/nixos-hardware";


    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    musnix.url = "github:musnix/musnix";
    musnix.inputs.nixpkgs.follows = "nixpkgs";

    mobile-nixos.url = "github:archseer/mobile-nixos/flake";
  };

  outputs = inputs @ {
    self,
    home,
    nixos,
    nixpkgs,
    hardware,
    nixos-wsl,
    disko,
    mobile-nixos,
    ...
  }: let
    inherit (builtins) attrValues;
    inherit (nixos) lib;

    systems = [
      # "aarch64-linux"
      # "i686-linux"
      "x86_64-linux"
      # "aarch64-darwin"
      # "x86_64-darwin"
    ];

    # Wrapper function to map a function over systems list
    forEachSystem = lib.genAttrs systems;
    
    pkgsFor = nixpkgs: overlays: system:
      import nixpkgs {
        inherit system overlays;
        config.allowUnfree = true;
      };

    linuxSystem = "x86_64-linux";

    overlay = import ./pkgs;

    pkgs' = pkgsFor nixos [overlay];
    # unstable' = pkgsFor nixpkgs [];

    mkSystem = pkgs: system: hostName: let
      # unstablePkgs = unstable' system;
      osPkgs = pkgs' system;
    in
      pkgs.lib.nixosSystem {
        inherit system;

        # pass through to modules
        specialArgs = {inherit inputs;};

        modules = let
          inherit (home.nixosModules) home-manager;
          inherit (nixos-wsl.nixosModules) wsl;
          core = ./profiles/core;

          global = {
            networking.hostName = hostName;
            nix.nixPath = let
              path = toString ./.;
            in [
              "nixpkgs=${nixpkgs}"
              "nixos=${nixos}"
              "nixos-config=${path}/configuration.nix"
              "home-manager=${home}"
            ];

            nixpkgs.pkgs = osPkgs;

            # conflicts definition below
            nixpkgs.flake.setNixPath = false;
            nixpkgs.flake.setFlakeRegistry = false;

            nix.registry = {
              nixpkgs.flake = nixpkgs;
              snowflake.flake = self;
              nixos.flake = nixos;
              home-manager.flake = home;
            };

            system.configurationRevision = lib.mkIf (self ? rev) self.rev;
          };

          hostConfiguration = import ./hosts/${hostName};

          # Everything in `./modules/list.nix`.
          flakeModules = attrValues self.nixosModules;
        in
          flakeModules ++
          [
            wsl
            core
            global
            hostConfiguration
            home-manager
            disko.nixosModules.disko
            inputs.musnix.nixosModules.musnix
          ];
      };

    outputs = {
      nixosConfigurations = {
        babadir = mkSystem nixos linuxSystem "babadir";
        iso = mkSystem nixos linuxSystem "iso";
        wsl = mkSystem nixos linuxSystem "wsl";
      };

      nixosModules = {};

      inherit overlay;
      devShell = forEachSystem (system: import ./shell.nix {pkgs = pkgs' system;});
      formatter = forEachSystem (system: nixpkgs.legacyPackages.${system}.alejandra);
    };
  in
    outputs;
}
