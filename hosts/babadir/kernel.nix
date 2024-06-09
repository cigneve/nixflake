{
  lib,
  stdenv,
  buildPackages,
  fetchurl,
  linuxManualConfig,
  pkgs,
  kernelPatches,
  ...
}: let
  linux = pkgs.linuxKernel.kernels.linux_6_9`;
  g14patches = fetchGit {
    url = "https://gitlab.com/dragonn/linux-g14";
    ref = "6.9";
    rev = "52ac92f9b6085f3b2c7edac93dec412dbe9c01b4";
  };
  # linux = pkgs.linuxPackages_latest;
   #linux = pkgs.callPackage ./linux-6.0.nix {};

  kernel =
    linuxManualConfig {
      inherit (linux) stdenv version modDirVersion src;
      inherit lib;
      configfile = ./kernel.config;
      kernelPatches = map (patch: {inherit patch; }) [
        
  "${g14_patches}/0001-acpi-proc-idle-skip-dummy-wait.patch"

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

   builtins.fetchUrl "https://raw.githubusercontent.com/cachyos/kernel-patches/master/6.9/sched/0001-sched-ext.patch";

  "${g14_patches}/0003-hid-asus-add-USB_DEVICE_ID_ASUSTEK_DUO_KEYBOARD.patch"
  "${g14_patches}/0005-asus-wmi-don-t-error-out-if-platform_profile-already.patch"
  "${g14_patches}/sys-kernel_arch-sources-g14_files-0047-asus-nb-wmi-Add-tablet_mode_sw-lid-flip.patch"
  "${g14_patches}/sys-kernel_arch-sources-g14_files-0048-asus-nb-wmi-fix-tablet_mode_sw_int.patch"

  builtins.fetchUrl "https://raw.githubusercontent.com/graysky2/kernel_compiler_patch/master/more-uarches-for-kernel-6.8-rc4%2B.patch";

  # Dummy patch for adding G14 kernel configurations
  {
    name = "g14-dummy";
    patch = "null";
    extraConfig = ''
                   PINCTRL_AMD y 
                   X86_AMD_PSTATE y 
                   AMD_PMC m

                   MODULE_COMPRESS_NONE  n
                   MODULE_COMPRESS_ZSTD y 

                   LRU_GEN y 
                   LRU_GEN_ENABLED y 
                   LRU_GEN_STATS n 
                   NR_LRU_GENS 7
                   TIERS_PER_GEN 4

                   INFINIBAND  n
                   DRM_NOUVEAU  n
                   PCMCIA_WL3501  n
                   PCMCIA_RAYCS  n
                   IWL3945  n
                   IWL4965  n
                   IPW2200  n
                   IPW2100  n
                   FB_NVIDIA  n
                   SENSORS_ASUS_EC  n
                   SENSORS_ASUS_WMI_EC n 

                   RAPIDIO  n
                   CDROM  m
                   PARIDE  n

                   CMDLINE_BOOL  y
                   CMDLINE makepkgplaceholderyolo
                   CMDLINE_OVERRIDE n 

                   EFI_HANDOVER_PROTOCOL  y
                   EFI_STUB y 

                   HW_RANDOM_TPM n 

                   SCHED_CLASS_EXT y
                  '';
  }
  ] # TODO: pass through kernelPatches
      allowImportFromDerivation = true;
    };
  #pkgs.overlays = [(final: super: {makeModulesClosure = x: super.makeModulesClosure (x // {allowMissing = true; } );})];
  passthru = {
    # TODO: confirm all these stil apply
    features = {
      # iwlwifi = true;
      # efiBootStub = true;
      # needsCifsUtils = true;
      # netfilterRPFilter = true;
      # ia32Emulation = true;
    };
  };

  finalKernel = lib.extendDerivation true passthru kernel;
in
  finalKernel
