{
  lib,
  inputs,
  config,
  pkgs,
  ...
}: {
  require = [
    inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.asus-zephyrus-ga401
    inputs.hardware.nixosModules.common-cpu-amd-pstate
    "${inputs.hardware.outPath}/common/gpu/nvidia/prime.nix"
    inputs.hardware.nixosModules.common-pc-laptop
    inputs.hardware.nixosModules.common-pc-laptop-ssd
    # inputs.hardware.nixosModules.asus-battery
  ];

  hardware = {
    amdgpu.initrd.enable = true;
    graphics.extraPackages = with pkgs; [
      vaapiVdpau
      libvdpau-va-gl
    ];
    nvidia = {
      modesetting.enable = true;
      nvidiaSettings = true;
      prime = {
        offload = {
          enable = true;
          enableOffloadCmd = true;
        };
        amdgpuBusId = "PCI:65:0:0";
        nvidiaBusId = "PCI:1:0:0";
      };
    };
  };

  boot.kernelParams = ["cryptomgr.notests" "quiet"];

  boot.blacklistedKernelModules = [ "nouveau" ];

  # hardware.nvidia.powerManagement = {
  #   enable = true;
  #   finegrained = true;
  # };

  # Only load the crypto modules required instead of a blanket import.
  boot.initrd.luks.cryptoModules = ["aes" "aes_generic" "cbc" "xts" "lrw" "sha1" "sha256" "sha512" "algif_skcipher"];

  # Load surface_aggregator / surface_hid at stage 1 so we can use the keyboard
  # during LUKS.



  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "nvme"
    "thunderbolt"
    "rtsx_pci_sdmmc"
    "ahci" "usbhid" "usb_storage" "sd_mod" "dm_mod" "dm_crypt" "cryptd" "atkbd" "i8042"
    # "rt18xxxu"
    # "rt18xxxu_core"
    # "ice_switch"
    # "acx"
    # "ice_main"
    # "ton"
    # "ufshcd"
    # "rtl8821ae"

  ];
  # boot.extraModulePackages = with boot.kernelPackages;[dm_mod];
  boot.kernelModules = ["kvm-amd"];

}
