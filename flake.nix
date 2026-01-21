{
  description = "My personal config";

  inputs = {
    nixos.url = "nixpkgs/nixos-unstable";
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-24.05";


    home.url = "github:rycee/home-manager";
    home.inputs.nixpkgs.follows = "nixpkgs";

    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    hardware.url = "github:NixOS/nixos-hardware";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    musnix.url = "github:musnix/musnix";
    musnix.inputs.nixpkgs.follows = "nixpkgs";

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home";
    };

    vsc-extensions = {
        url = "github:nix-community/nix-vscode-extensions";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:nix-darwin/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home";
    };
    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    # Optional: Declarative tap management
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

  };

  outputs = inputs @ {
    self,
    home,
    nixos,
    darwin,
    nixpkgs,
    hardware,
    nixos-wsl,
    disko,
    plasma-manager,
    vsc-extensions,
    ...
  }: let
    inherit (builtins) attrValues;
    inherit (nixos) lib;

    systems = [
      # "aarch64-linux"
      # "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
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

    overlay = import ./pkgs inputs;

    pkgs' = pkgsFor nixos [overlay];
    # unstable' = pkgsFor nixpkgs [];

    mkSystem = mkSystemForOs nixpkgs.lib.nixosSystem; 

    mkSystemForOs = systemFunc: pkgs: system: hostName: let
      # unstablePkgs = unstable' system;
      osPkgs = pkgsFor pkgs [overlay vsc-extensions.overlays.default] system;
    in
      systemFunc {
        inherit system;

        # pass through to modules
        specialArgs = {inherit inputs;};

        modules = let
          home-manager-module = (home.nixosModules).home-manager;
          wsl-module = (nixos-wsl.nixosModules).wsl;
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
          flakeModules
          ++ [
            global
            core
            hostConfiguration
          ]
          ++
          (if osPkgs.stdenv.isLinux then [
            wsl-module
            home-manager-module
            disko.nixosModules.disko
            inputs.musnix.nixosModules.musnix
            {
              home-manager.sharedModules = [plasma-manager.homeManagerModules.plasma-manager];
            }
          ] else [
            home.darwinModules.home-manager
            ]);
      };

    outputs = {
      nixosConfigurations = {
        babadir = mkSystem nixos linuxSystem "babadir";
        iso = mkSystem nixos linuxSystem "iso";
        wsl = mkSystem nixos linuxSystem "wsl";
        t480 = mkSystem nixos linuxSystem "t480";
        elitedesk = mkSystem nixos linuxSystem "elitedesk";
        vm = mkSystem nixos "aarch64-linux" "vm";
      };

      darwinConfigurations = {
        mba = mkSystemForOs darwin.lib.darwinSystem nixos "aarch64-darwin" "mba"; 
      };

      nixosModules = {};

      inherit overlay;
      devShell = forEachSystem (system: import ./shell.nix {pkgs = pkgs' system;});
      formatter = forEachSystem (system: nixpkgs.legacyPackages.${system}.alejandra);
    };
  in
    outputs;
}
