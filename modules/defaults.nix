{
  den,
  inputs,
  ...
}: {
  den.schema.flake-parts.includes = [
    # Enter flake-parts scope from flake-system.
    den.policies.system-to-flake-parts

    # Exclude vanilla packages route — handled via flake-parts scope.
    # den.policies.packages-to-flake
  ];

  den.default.nixos = {
    pkgs,
    lib,
    ...
  }: {
    imports = [
      # Adds the NUR overlay
      inputs.nur.modules.nixos.default
      # NUR modules to import
      # inputs.nur.legacyPackages."${system}".repos.iopq.modules.xraya
      # This adds the NUR nixpkgs overlay.
      # Example:
      # ({ pkgs, ... }: {
      #   environment.systemPackages = [ pkgs.nur.repos.mic92.hello-nur ];
      # })
    ];

    hardware.enableAllFirmware = true;
    hardware.enableRedistributableFirmware = true;

    programs.appimage = {
      enable = true;
      binfmt = true;
    };

    # FIXME: Would be nice to have, but fails too often.
    systemd.enableStrictShellChecks = false;

    nixpkgs = {
      overlays = let
        # When applied, the stable nixpkgs set (declared in the flake inputs) will
        # be accessible through 'pkgs.stable'
        stablePackages = final: _: {
          stable = import inputs.nixpkgs-stable {
            inherit (final.stdenv.hostPlatform) system;
            inherit (final) config;
          };
        };
      in [
        # Add overlays your own flake exports (from overlays and pkgs dir):
        # inputs.self.overlays.additions
        # inputs.self.overlays.modifications
        stablePackages

        # inputs.nur.overlays.default

        # You can also add overlays exported from other flakes:
        # neovim-nightly-overlay.overlays.default
        #inputs.agenix.overlays.default

        # Or define it inline, for example:
        # (final: prev: {
        #   hi = final.hello.overrideAttrs (oldAttrs: {
        #     patches = [ ./change-hello-to-hi.patch ];
        #   });
        # })
      ];
      config = {
        # Disable if you don't want unfree packages
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
    };

    # system = {
    #   autoUpgrade = {
    #     enable = true;
    #     flake = "file+git://~/.nixos-config";
    #   };
    # };

    nix =
      # let
      #   flakeInputs = lib.filterAttrs (_: lib.isType "flake") inputs;
      # in
      {
        # package =
        #   lib.mkForce
        #     # pkgs.nix;
        #     # pkgs.nixVersions.latest;
        #     # pkgs.lixPackageSets.latest.lix;
        #     inputs.determinate.packages.${pkgs.stdenv.hostPlatform.system}.default;

        # This will add each flake input as a registry
        # To make nix3 commands consistent with your flake
        # registry = (lib.mapAttrs (_: flake: { inherit flake; })) (
        #   # (lib.filterAttrs (_: lib.isType "flake"))
        #   inputs
        # );

        # Garbage collecting.
        gc = {
          automatic = true;
          dates = "weekly";
          options = "--delete-older-than 7d";
        };

        settings = {
          experimental-features = [
            "auto-allocate-uids"
            "blake3-hashes"
            "ca-derivations"
            "cgroups"
            "dynamic-derivations"
            "fetch-closure"
            "fetch-tree"
            "flakes"
            "git-hashing"
            "impure-derivations"
            #"local-overlay-store"
            "nix-command"
            "parse-toml-timestamps"
            "pipe-operators"
            # "pipe-operator"
            "read-only-local-store"
            "recursive-nix"
            # "repl-automation"
            # Mounted SSH store (`mounted-ssh-store`)
            # Local overlay store (`local-overlay-store`)
            # Allow impure environment variables in the execution environment (`configurable-impure-env`)
            # Allow forcing trust settings for the Nix daemon (`daemon-trust-override`)
          ];

          auto-allocate-uids = true;

          # Deduplicate and optimize nix store
          auto-optimise-store = true;

          # Opinionated: disable global registry
          #flake-registry = "";
          # Workaround for https://github.com/NixOS/nix/issues/9574
          # nix-path = config.nix.nixPath;

          lazy-trees = true;

          lint-url-literals = "fatal";
          # lint-short-path-literals = "warn";
          # lint-absolute-path-literals = "warn";

          warn-dirty = false;

          # Avoid unwanted garbage collection when using nix-direnv.
          keep-outputs = true;
          keep-derivations = true;

          trusted-users = [
            "root"
            "@wheel"
          ];
        };
        # Completely disable channels.
        channel.enable = false;
      };

    # Bootloader
    boot = {
      loader = {
        systemd-boot.enable = true;
        grub = {
          enable = lib.mkForce true;
          #device = "/dev/nvme0n1p5";
          device = "nodev";
          efiSupport = true;
          #efiInstallAsRemovable = true; # in case canTouchEfiVariables doesn't work for your system
          useOSProber = true;
          configurationLimit = 10;
        };
        efi = {
          canTouchEfiVariables = true;
          efiSysMountPoint = "/boot/efi";
        };
        timeout = null; # Remain in boot menu indefinitely.
      };
      supportedFilesystems = [
        "ntfs"
      ];
      # kernelPackages = ;
      # kernelPackages = pkgs.linuxPackages_latest;
      kernelPackages = pkgs.linuxPackages_xanmod_latest;
      extraModulePackages = [
        # pkgs.linuxPackages_zen.kernel
        # pkgs.linuxPackages_latest.kernel
      ];
      # initrd.kernelModules = [
      #   "amdgpu"
      # ];
    };

    services.envfs = {
      enable = true;
      extraFallbackPathCommands = ''
        ln -s ${pkgs.bash}/bin/bash $out/bash
      '';
    };

    # Enable networking
    networking.networkmanager.enable = true;
    time.timeZone = "Europe/Istanbul";

    # Select internationalisation properties.
    i18n.defaultLocale = lib.mkForce "en_GB.UTF-8";

    environment = {
      systemPackages = with pkgs; [
        binutils
        coreutils
        moreutils
        curl
        dnsutils
        dosfstools
        fd
        git
        htop
        jq
        nmap
        sd
        ripgrep
        util-linux
        whois
        gnupg
      ];

      shells = with pkgs; [
        bash
        zsh
        fish
        dash
      ];
    };

    programs.nano.enable = false;
    users.defaultUserShell = pkgs.dash;

    programs.gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };

    services.fstrim = {
      enable = true;
    };

    systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true"; # Don't create default ~/Sync folder.

    den.default.homeManager = {
      programs.home-manager.enable = true;

      # Nicely reload system units when changing configs
      systemd.user.startServices = "sd-switch";
    };

    den.schema.user.includes = [den.batteries.mutual-provider];
  };
}
