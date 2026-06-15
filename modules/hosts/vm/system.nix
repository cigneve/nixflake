{
  cig,
  den,
  pkgs,
  lib,
  ...
}: let
  linuxPackages = pkgs.linuxPackages_latest;
in {
  den.hosts.x86_64-linux.utm = {
    description = "UTM vm";
    users.baba = {};
  };

  den.aspects.utm = {
    includes = with cig; [
      services
      services._.immich
      services._.karakeep
      services._.kavita
      services._.mealie
      services._.readeck
      services._.stalwart
      security._.sops
      (den.batteries.vm-autologin "bab")
    ];
    nixos = {
      includes = [
        ./disko.nix
      ];
      networking.firewall.enable = lib.mkForce false;

      boot.loader.systemd-boot.enable = true;
      # boot.loader.systemd-boot.editor = false;

      # use the custom kernel config
      boot.kernelPackages = linuxPackages;

      # use zstd compression instead of gzip for initramfs.
      boot.initrd.compressor = "zstd";

      boot.loader.efi.canTouchEfiVariables = true;

      # # btrfs
      # boot.initrd.supportedFilesystems = ["btrfs"];
      # services.btrfs.autoScrub.enable = true;

      # Disk
      ## We imported the needed disk configuration from disko.nix

      hardware = {
        enableAllFirmware = true;
        firmware = [pkgs.wireless-regdb];
      };

      # nix.maxJobs = lib.mkDefault 8;
      # nix.systemFeatures = [ "gccarch-haswell" ];

      # Track list of enabled modules for localmodconfig generation.
      environment.systemPackages = with pkgs; [
        modprobed-db
        btrfs-progs
        compsize
      ];
      services.spice-autorandr.enable = true;
      services.spice-vdagentd.enable = true;
      services.spice-webdavd.enable = true;

      # This value determines the NixOS release from which the default
      # settings for stateful data, like file locations and database versions
      # on your system were taken. It‘s perfectly fine and recommended to leave
      # this value at the release version of the first install of this system.
      # Before changing this value read the documentation for this option
      # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
      system.stateVersion = "25.11"; # Did you read the comment?
    };
  };
}
