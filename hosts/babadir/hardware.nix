{
  lib,
  inputs,
  config,
  ...
}: {
  require = [
    inputs.hardware.nixosModules.common-cpu-amd
    # inputs.hardware.nixosModules.asus-zephyrus-ga401
    inputs.hardware.nixosModules.common-cpu-amd-pstate
    inputs.hardware.nixosModules.common-gpu-nvidia
    inputs.hardware.nixosModules.common-pc-laptop
    inputs.hardware.nixosModules.common-pc-laptop-ssd
    # inputs.hardware.nixosModules.asus-battery
  ];

  hardware.nvidia.prime = {amdgpuBusId = "PCI:4:0:0";nvidiaBusId = "PCI:1:0:0";};

  boot.kernelParams = ["cryptomgr.notests"];

  # hardware.nvidia.powerManagement = {
  #   enable = true;
  #   finegrained = true;
  # };

  # Only load the crypto modules required instead of a blanket import.
  boot.initrd.luks.cryptoModules = ["aes" "aes_generic" "cbc" "xts" "lrw" "sha1" "sha256" "sha512" "algif_skcipher"];

  # Load surface_aggregator / surface_hid at stage 1 so we can use the keyboard
  # during LUKS.

  # upstream includes SATA drivers etc. which we don't build into the kernel.

  # boot.initrd.includeDefaultModules = false;
  # boot.initrd.availableKernelModules = lib.mkForce [
  #   "xhci_pci"
  #   "nvme"
  #   "sd_mod"
  #   "dm_mod"
  #   "dm_crypt"
  #   "cryptd"
  #   # required for keyboard support at init
  #   # "intel_lpss"
  #   # "intel_lpss_pci"
  #   "8250_dw"
  #   "surface_aggregator"
  #   "surface_aggregator_registry"
  #   "surface_hid_core"
  #   "surface_hid"
  # ];

  boot.initrd.availableKernelModules = [
    "xhci_pci"
    "nvme"
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

  hardware.cpu.amd.updateMicrocode = true;
}
