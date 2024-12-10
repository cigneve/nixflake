{
  lib,
  pkgs,
  ...
}: let
  linuxPackages = pkgs.linuxPackages_latest;
in {
  imports = [
    ./hardware.nix
    # sudo nix run github:nix-community/disko --extra-experimental-features flakes --extra=experimental-features nix-command -- --mode disko --flake github:archseer/snowflake#trantor
    ./disko.nix
    # ../../profiles/zram # Use zram for swap
    ../../profiles/laptop
    ../../profiles/network # sets up wireless
    ../../profiles/graphical
    ../../profiles/misc/yubikey.nix
    ../../profiles/studio
    ../../users/baba
    ../../users/root
  ];

  services.throttled  = {
    enable = true;
    extraConfig = ''
      [UNDERVOLT]
      CORE: -105
      GPU: -85
      CACHE: -105
      UNCORE: -85
      ANALOGIO: 0
    '';
  };

  services.power-profiles-daemon.enable = lib.mkForce false;

  networking.firewall.enable = lib.mkForce false;

  boot.loader.systemd-boot.enable = true;

  # use the custom kernel config
  boot.kernelPackages = linuxPackages;

  # use zstd compression instead of gzip for initramfs.
  boot.initrd.compressor = "zstd";

  boot.loader.efi.canTouchEfiVariables = true;

  # btrfs
  boot.initrd.supportedFilesystems = ["btrfs"];
  services.btrfs.autoScrub.enable = true;

  # Disk
  ## We imported the needed disk configuration from disko.nix

  ## Resume from encrypted volume's /swapfile
  # swapDevices = [ { device = "/swap/swapfile";priority=0; } ];
  boot.resumeDevice = "/dev/sda2";

  # TODO: declarative approach for this?
  # filefrag -v /swapfile | awk '{ if($1=="0:"){print $4} }'
  boot.kernelParams = ["resume_offset=269568" "mitigations=off"];

  hardware = {
    enableAllFirmware = true;
    firmware = [pkgs.wireless-regdb];
  };

  # nix.maxJobs = lib.mkDefault 8;
  # nix.systemFeatures = [ "gccarch-haswell" ];

  # powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  # Track list of enabled modules for localmodconfig generation.
  environment.systemPackages = [
    pkgs.modprobed-db
    pkgs.btrfs-progs
    pkgs.compsize
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
