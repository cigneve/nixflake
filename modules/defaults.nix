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

        nix = {
          gc.automatic = true;
          optimise.automatic = true;
          settings = {
            cores = 0;
            # auto-optimise-store = true;
            # sandbox = true;
            allowed-users =
              if pkgs.stdenv.isLinux
              then ["@wheel"]
              else ["@admin"];
            trusted-users = ["root" "@wheel"];
          };
          extraOptions = ''
            experimental-features = nix-command flakes
            keep-outputs = true
            keep-derivations = true
          '';
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

    den.default.includes = [
      # ${user}.provides.${host} and ${host}.provides.${user}
      # FIXME: Explicit definition and include maybe unnecessary now? Enabled by default by den, it seems.
      # <addax/routes>

      # Automatically create the user on host.
      # <den/define-user>
      den.batteries.define-user

      # Provides the `flake-parts` `self'` (the flake's `self` with system pre-selected) as a top-level module argument.
      # This allows modules to access per-system flake outputs without needing
      # `pkgs.stdenv.hostPlatform.system`.
      # ## Usage
      # **Global (Recommended):**
      # Apply to all hosts, users, and homes.
      #     den.default.includes = [ den._.self' ];
      # **Specific:**
      # Apply only to a specific host, user, or home aspect.
      #     den.aspects.my-laptop.includes = [ den._.self' ];
      #     den.aspects.alice.includes = [ den._.self' ];
      # **Note:** This aspect is contextual. When included in a `host` aspect, it
      # configures `self'` for the host's OS. When included in a `user` or `home`
      # aspect, it configures `self'` for the corresponding Home Manager configuration.
      den.batteries.self'

      # Provides the `flake-parts` `inputs'` (the flake's `inputs` with system pre-selected)
      # as a top-level module argument.
      # This allows modules to access per-system flake outputs without needing
      # `pkgs.stdenv.hostPlatform.system`.
      # ## Usage
      # **Global (Recommended):**
      # Apply to all hosts, users, and homes.
      #     den.default.includes = [ den._.inputs' ];
      # **Specific:**
      # Apply only to a specific host, user, or home aspect.
      #     den.aspects.my-laptop.includes = [ den._.inputs' ];
      #     den.aspects.alice.includes = [ den._.inputs' ];
      # **Note:** This aspect is contextual. When included in a `host` aspect, it
      # configures `inputs'` for the host's OS. When included in a `user` or `home`
      # aspect, it configures `inputs'` for the corresponding Home Manager configuration.
      den.batteries.inputs'

      # Recursively imports non-dendritic .nix files depending on their Nix configuration `class`.
      # This can be used to help migrating from huge existing setups.
      # ```
      #   # this is at <repo>/modules/non-dendritic.nix
      #   den.aspects.my-laptop.includes = [
      #     (den._.import-tree._.host ../non-dendritic)
      #   ]
      # ```
      # With following structure, it will automatically load modules depending on their class.
      # ```
      #     <repo>/
      #       modules/
      #         non-dendritic.nix # configures this aspect
      #       non-dendritic/ # name is just an example here
      #         hosts/
      #           my-laptop/
      #             _nixos/          # a directory for `nixos` class
      #               auto-generated-hardware.nix # any nixos module
      #             _darwin/
      #               foo.nix
      #             _homeManager/
      #               me.nix
      # ```
      # ## Requirements
      #   - inputs.import-tree
      # ## Usage
      #   this aspect can be included explicitly on any aspect:
      #       # example: will import ./disko/_nixos files automatically.
      #       den.aspects.my-disko.includes = [ (den._.import-tree ./disko/) ];
      #   or it can be default imported per host/user/home:
      #       # load from ./hosts/<host>/_nixos
      #       den.default.includes = [ (den._.import-tree._.host ./hosts) ];
      #       # load from ./users/<user>/{_homeManager, _nixos}
      #       den.default.includes = [ (den._.import-tree._.user ./users) ];
      #       # load from ./homes/<home>/_homeManager
      #       den.default.includes = [ (den._.import-tree._.home ./homes) ];
      #   you are also free to create your own auto-imports layout following the implementation of these.

      # Set the networking host name from host.hostName.
      den.batteries.hostname

      # NOTE: be cautious when adding fully parametric functions to defaults.
      # defaults are included on EVERY host/user/home, and IF you are not careful
      # you could be duplicating config values. For example:
      #
      #  # This will append 42 into foo option for the {host} and for EVERY {host,user}
      #  ({ host, ... }: { nixos.foo = [ 42 ]; }) # DO-NOT-DO-THIS.
      #
      #  # Instead try to be explicit if a function is intended for ONLY { host }.
      # (den.lib.take.exactly (
      #   { host }:
      #   {
      #     nixos.networking.hostName = host.hostName;
      #   }
      # ))
    ];
  };
}
