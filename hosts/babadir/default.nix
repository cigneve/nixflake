{
  lib,
  pkgs,
  ...
}: let
  kernel = pkgs.callPackage ./kernel.nix {};
  # kernel = pkgs.callPackage ./linux-6.0.nix {};
  g14_patches = fetchGit {
    url = "https://gitlab.com/dragonn/linux-g14";
    ref = "6.9";
    rev = "52ac92f9b6085f3b2c7edac93dec412dbe9c01b4";
  };
 #linuxPackages = pkgs.linuxPackages_6_9;
 linuxPackages = pkgs.linuxPackagesFor kernel;
in {
  imports = [
    ./hardware.nix
    # Take an empty *readonly* snapshot of the root subvolume,
    # which we'll eventually rollback to on every boot.
    # sudo mount /dev/mapper/cryptroot -o subvol=root /mnt/root
    # btrfs subvolume snapshot -r /mnt/root /mnt/root-blank

    # sudo nix run github:nix-community/disko --extra-experimental-features flakes --extra=experimental-features nix-command -- --mode disko --flake github:archseer/snowflake#trantor
    # --arg disks ["/dev/nvme0p1"] not necessary?
    ./disko.nix
    ../../profiles/zram # Use zram for swap
    ../../profiles/laptop
    ../../profiles/network # sets up wireless
    ../../profiles/graphical/games
    ../../profiles/graphical
    ../../profiles/misc/yubikey.nix
    ../../users/baba
    ../../users/root
  ];

  services.asusd= {
    enable = true;
    enableUserService = true;
  };
  services.supergfxd = {
    enable = true;
  };

  services.power-profiles-daemon.enable = true;
  systemd.services.power-profiles-daemon = {
    enable = true;
    wantedBy = [ "multi-user.target" ];
  };

  networking.firewall.enable = lib.mkForce false;

  boot.loader.systemd-boot.enable = true;
  # boot.loader.systemd-boot.editor = false;



 # All kernel patches for g14
 boot.kernelPatches = (map (patch: {inherit patch; }) [
"${g14_patches}/0001-acpi-proc-idle-skip-dummy-wait.patch"
  # "${g14_patches}/0001-acpi-proc-idle-skip.patch"
 "${g14_patches}/v4-0001-platform-x86-asus-wmi-add-support-for-2024-ROG-Mi.patch"
 "${g14_patches}/v4-0002-platform-x86-asus-wmi-add-support-for-Vivobook-GP.patch"
 "${g14_patches}/v4-0003-platform-x86-asus-wmi-add-support-variant-of-TUF-.patch"
 "${g14_patches}/v4-0004-platform-x86-asus-wmi-support-toggling-POST-sound.patch"
 "${g14_patches}/v4-0005-platform-x86-asus-wmi-store-a-min-default-for-ppt.patch"
 "${g14_patches}/v4-0006-platform-x86-asus-wmi-adjust-formatting-of-ppt-na.patch"
 "${g14_patches}/v4-0007-platform-x86-asus-wmi-ROG-Ally-increase-wait-time.patch"
 "${g14_patches}/v4-0008-platform-x86-asus-wmi-Add-support-for-MCU-powersa.patch"
 "${g14_patches}/v4-0009-platform-x86-asus-wmi-cleanup-main-struct-to-avoi.patch"

 "${g14_patches}/0001-platform-x86-asus-wmi-add-support-for-vivobook-fan-p.patch"

"${g14_patches}/0001-HID-asus-fix-more-n-key-report-descriptors-if-n-key-.patch"
"${g14_patches}/0002-HID-asus-make-asus_kbd_init-generic-remove-rog_nkey_.patch"
"${g14_patches}/0003-HID-asus-add-ROG-Ally-N-Key-ID-and-keycodes.patch"
"${g14_patches}/0004-HID-asus-add-ROG-Z13-lightbar.patch"

"${g14_patches}/0001-ALSA-hda-realtek-Adjust-G814JZR-to-use-SPI-init-for-.patch"
"${g14_patches}/0001-platform-x86-asus-wmi-add-debug-print-in-more-key-pl.patch"
"${g14_patches}/0002-platform-x86-asus-wmi-don-t-fail-if-platform_profile.patch"
"${g14_patches}/0003-asus-bios-refactor-existing-tunings-in-to-asus-bios-.patch"
"${g14_patches}/0004-asus-bios-add-panel-hd-control.patch"
"${g14_patches}/0005-asus-bios-add-dgpu-tgp-control.patch"
"${g14_patches}/0006-asus-bios-add-apu-mem.patch"
"${g14_patches}/0007-asus-bios-add-core-count-control.patch"
#0008-asus-wmi-deprecate-bios-features.patch
 "${g14_patches}/v2-0001-hid-asus-use-hid-for-brightness-control-on-keyboa.patch"
 "${g14_patches}/0003-platform-x86-asus-wmi-add-macros-and-expose-min-max-.patch"


 
 "${g14_patches}/0027-mt76_-mt7921_-Disable-powersave-features-by-default.patch"
 
"${g14_patches}/0032-Bluetooth-btusb-Add-a-new-PID-VID-0489-e0f6-for-MT7922.patch"
 "${g14_patches}/0035-Add_quirk_for_polling_the_KBD_port.patch"

 "${g14_patches}/0001-ACPI-resource-Skip-IRQ-override-on-ASUS-TUF-Gaming-A.patch"
 "${g14_patches}/0002-ACPI-resource-Skip-IRQ-override-on-ASUS-TUF-Gaming-A.patch"

 "${g14_patches}/v2-0005-platform-x86-asus-wmi-don-t-allow-eGPU-switching-.patch"

 "${g14_patches}/0038-mediatek-pci-reset.patch"
 "${g14_patches}/0040-workaround_hardware_decoding_amdgpu.patch"

 "${g14_patches}/0001-platform-x86-asus-wmi-Support-2023-ROG-X16-tablet-mo.patch"
 "${g14_patches}/amd-tablet-sfh.patch"

  # builtins.fetchurl {url="https://raw.githubusercontent.com/cachyos/kernel-patches/master/6.9/sched/0001-sched-ext.patch";sha256="";}

 "${g14_patches}/0003-hid-asus-add-USB_DEVICE_ID_ASUSTEK_DUO_KEYBOARD.patch"
 "${g14_patches}/0005-asus-wmi-don-t-error-out-if-platform_profile-already.patch"
 "${g14_patches}/sys-kernel_arch-sources-g14_files-0047-asus-nb-wmi-Add-tablet_mode_sw-lid-flip.patch"
# "${g14_patches}/sys-kernel_arch-sources-g14_files-0048-asus-nb-wmi-fix-tablet_mode_sw_int.patch"

  #builtins.fetchurl {url="https://raw.githubusercontent.com/graysky2/kernel_compiler_patch/master/more-uarches-for-kernel-6.8-rc4%2B.patch";sha256="";}

]
 ++ 
# Dummy patch for adding G14 kernel configurations
[{
   name = "g14-dummy";
   patch = null;
   extraStructuredConfig = {
                  PINCTRL_AMD= lib.kernel.yes; 
                  X86_AMD_PSTATE= lib.kernel.yes; 
                  AMD_PMC= lib.kernel.module;

                  MODULE_COMPRESS_NONE = lib.kernel.no;
                  MODULE_COMPRESS_ZSTD= lib.kernel.yes; 

                  LRU_GEN= lib.kernel.yes; 
                  LRU_GEN_ENABLED= lib.kernel.yes; 
                  LRU_GEN_STATS= lib.kernel.no; 
                  # NR_LRU_GENS= 7;
                  # TIERS_PER_GEN= 4;

                  INFINIBAND = lib.mkDefault lib.kernel.no;
                  DRM_NOUVEAU = lib.kernel.no;
                  PCMCIA_WL3501 = lib.kernel.no;
                  PCMCIA_RAYCS = lib.kernel.no;
                  IWL3945 = lib.kernel.no;
                  IWL4965 = lib.kernel.no;
                  IPW2200 = lib.kernel.no;
                  IPW2100 = lib.kernel.no;
                  FB_NVIDIA = lib.kernel.no;
                  SENSORS_ASUS_EC = lib.kernel.no;
                  SENSORS_ASUS_WMI_EC= lib.kernel.no; 

                  RAPIDIO = lib.kernel.no;
                  CDROM = lib.kernel.module;
                  PARIDE = lib.kernel.no;

                  CMDLINE_BOOL = lib.kernel.yes;
                  CMDLINE= lib.kernel.module;
                  CMDLINE_OVERRIDE= lib.kernel.no; 

                  EFI_HANDOVER_PROTOCOL = lib.kernel.yes;
                  EFI_STUB= lib.kernel.yes; 

                  HW_RANDOM_TPM= lib.kernel.no; 

                  SCHED_CLASS_EXT= lib.kernel.yes;
                 };
 }
]
  );

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
  boot.resumeDevice = "/dev/nvme0n1p2";
  # filefrag -v /swapfile | awk '{ if($1=="0:"){print $4} }'
  boot.kernelParams = ["resume_offset=269568" "mitigations=off"];

  hardware = {
    enableAllFirmware = true;
    firmware = [pkgs.wireless-regdb];
  };

  # nix.maxJobs = lib.mkDefault 8;
  # nix.systemFeatures = [ "gccarch-haswell" ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";

  # Track list of enabled modules for localmodconfig generation.
  environment.systemPackages = [pkgs.modprobed-db
  pkgs.asusctl pkgs.supergfxctl
  pkgs.btrfs-progs pkgs.compsize];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
