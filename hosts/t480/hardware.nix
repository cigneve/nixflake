{
  lib,
  inputs,
  config,
  pkgs,
  ...
}: {
  require = [
    inputs.hardware.nixosModules.lenovo-thinkpad-t480s
    inputs.hardware.nixosModules.common-pc-laptop
    inputs.hardware.nixosModules.common-pc-laptop-ssd
  ];

  hardware = {
    graphics.extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  boot.kernelParams = ["cryptomgr.notests" "quiet"];


  # Only load the crypto modules required instead of a blanket import.
  boot.initrd.luks.cryptoModules = ["aes" "aes_generic" "cbc" "xts" "lrw" "sha1" "sha256" "sha512" "algif_skcipher"];

  # Load surface_aggregator / surface_hid at stage 1 so we can use the keyboard
  # during LUKS.

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "nvme"
    "thunderbolt"
    "rtsx_pci_sdmmc"
    "ahci"
    "usbhid"
    "usb_storage"
    "sd_mod"
    "dm_mod"
    "dm_crypt"
    "cryptd"
    "atkbd"
    "i8042"
    # "rt18xxxu"
    # "rt18xxxu_core"
    # "ice_switch"
    # "acx"
    # "ice_main"
    # "ton"
    # "ufshcd"
    # "rtl8821ae"
  ];
  boot.extraModulePackages = with config.boot.kernelPackages;[v4l2loopback];
  boot.kernelModules = ["v4l2loopback"];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=3 video_nr=7,8,9 exclusive_caps=1,1,1 card_label="Loopback-1,Loopback-2,Loopback-3"
  ''
  ;
}
