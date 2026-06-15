{
  lib,
  den,
  inputs,
  ...
}: {
  debug = true;
  flake-file.inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    git-hooks-nix = {
      url = "github:cachix/git-hooks.nix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-compat.follows = "flake-compat";
        # gitignore.follows = "gitignore-nix";
      };
    };

    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-26.05";

    vsc-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    determinate = {
      url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nix-maid.url = "github:viperML/nix-maid";

    # # We recommend following our Hjem input
    hjem.follows = "hjem-rum/hjem";

    # # You can also manage your own Hjem version, but this may come with breakage (read the admonition above)
    # hjem = {
    # url = "github:feel-co/hjem";
    # You may want hjem to use your defined nixpkgs input to
    # minimize redundancies.
    # inputs.nixpkgs.follows = "nixpkgs";
    # };
    hjem-rum = {
      url = "github:snugnug/hjem-rum";
      # You may want hjem-rum to use your defined nixpkgs input to
      # minimize redundancies.
      inputs.nixpkgs.follows = "nixpkgs";
      # Same goes for hjem, to avoid discrepancies between the version
      # you use directly and the one hjem-rum uses.
      # inputs.hjem.follows = "hjem";
    };
    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
    systems.url = "github:nix-systems/x86_64-linux";
    flake-compat = {
      url = "github:nix-community/flake-compat";
      # flake = false;
    };
    nix-formatter-pack = {
      url = "github:Gerschtli/nix-formatter-pack";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hardware.url = "github:NixOS/nixos-hardware/master";

    nur = {
      url = "github:nix-community/NUR";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };

    quadlet-nix = {
      url = "github:SEIAROTg/quadlet-nix";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  imports = [
    inputs.flake-parts.flakeModules.modules

    # inputs.flake-file.flakeModules.dendritic
    # inputs.flake-file.flakeModules.nix-auto-follow
    # inputs.flake-file.flakeModules.allfollow
    # inputs.flake-file.flakeModules.default
    # inputs.dendrix.vic-vix.macos-keys # example <macos-keys> aspect.
    # inputs.dendrix.vic-vix
    # inputs.dendrix.vix # example layer, see https://github.com/vic/dendrix/tree/main/dev/layers
    # inputs.devshell.flakeModule

    inputs.home-manager.flakeModules.home-manager

    # inputs.nix-maid.nixosModules.default
    # inputs.hjem.nixosModules.default

  ];

  systems = import inputs.systems;

  flake-file.description = "Adda's NixOS Flake configurations using the Dendritic pattern via the Den project";
  flake-file.prune-lock.enable = true;

  # Reusable nixos modules you might want to export
  # These are usually stuff you would upstream into nixpkgs
  # nixosModules = import ./modules/nixos;
  # Reusable home-manager modules you might want to export
  # These are usually stuff you would upstream into home-manager
  # homeManagerModules = import ./modules/home-manager;

  # Allow all aspects to contribute to the top-level flake outputs.
  den.schema.flake-system.into.host = {system}: map (host: {inherit host;}) (lib.attrValues den.hosts.${system});
}
