{
  lib,
  pkgs,
  ...
}: let
in {
  imports = [
    # ./hardware.nix
    # Take an empty *readonly* snapshot of the root subvolume,
    # which we'll eventually rollback to on every boot.
    # sudo mount /dev/mapper/cryptroot -o subvol=root /mnt/root
    # btrfs subvolume snapshot -r /mnt/root /mnt/root-blank

    # sudo nix run github:nix-community/disko --extra-experimental-features flakes --extra=experimental-features nix-command -- --mode disko --flake github:archseer/snowflake#trantor
    # --arg disks ["/dev/nvme0p1"] not necessary?
    # ./disko.nix
    # ../../profiles/zram # Use zram for swap
    # ../../profiles/laptop
    # ../../profiles/network # sets up wireless
    ../../profiles/graphical
    ../../profiles/develop
    # ../../profiles/misc/yubikey.nix
    ../../users/baba
    ../../users/root
  ];

  networking.firewall.enable = lib.mkForce false;

  # boot.loader.systemd-boot.enable = true;
  # boot.loader.systemd-boot.editor = false;

  # boot.loader.efi.canTouchEfiVariables = true;

  # btrfs
  # boot.initrd.supportedFilesystems = ["btrfs"];
  # services.btrfs.autoScrub.enable = true;

  # Disk
  ## We imported the needed disk configuration from disko.nix

  # hardware = {
  #   enableAllFirmware = true;
  #   firmware = [pkgs.wireless-regdb];
  # };

  # nix.maxJobs = lib.mkDefault 8;
  # nix.systemFeatures = [ "gccarch-haswell" ];

  # Track list of enabled modules for localmodconfig generation.
  # environment.systemPackages = [pkgs.modprobed-db
  #  pkgs.compsize];

  wsl = {
    enable = true;
    wslConf.automount.root = "/mnt";
    wslConf.interop.appendWindowsPath = false;
    wslConf.network.generateHosts = false;
    defaultUser = "baba";
    startMenuLaunchers = true;
    # Enable integration with Docker Desktop (needs to be installed)
    docker-desktop.enable = false;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
