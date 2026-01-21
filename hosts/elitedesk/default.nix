{
  lib,
  pkgs,
  ...
}: let
  linuxPackages = pkgs.linuxPackages_latest;
in {
  imports = [
    ../../profiles/zram # Use zram for swap
    # sudo nix run github:nix-community/disko --extra-experimental-features flakes --extra=experimental-features nix-command -- --mode disko --flake github:archseer/snowflake#trantor
    ./disko.nix
    ../../profiles/graphical
    ../../profiles/studio
    ../../users/baba
    ../../users/root
  ];


  boot.loader.systemd-boot.enable = true;

  # use the custom kernel config
  boot.kernelPackages = linuxPackages;
  boot.initrd.compressor = "zstd";

  boot.loader.efi.canTouchEfiVariables = true;

  # btrfs
  boot.initrd.supportedFilesystems = ["btrfs"];
  services.btrfs.autoScrub.enable = true;

  hardware = {
    enableAllFirmware = true;
    firmware = [pkgs.wireless-regdb];
  };

  # nix.maxJobs = lib.mkDefault 8;
  # nix.systemFeatures = [ "gccarch-haswell" ];

  # powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
