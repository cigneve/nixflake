{
  lib,
  stdenv,
  buildPackages,
  fetchurl,
  linuxManualConfig,
  pkgs,
#  kernelPatches,
  ...
}: let
  #linux = pkgs.linuxKernel.kernels.linux_6_9;
   #linux = pkgs.linuxPackages_6_8;
   linux = pkgs.callPackage ./linux-6.0.nix {};

 # kernel =
  #  linuxManualConfig {
    #  inherit (linux) stdenv version modDirVersion src;
   #   inherit lib;
     # configfile = ./kernel.config;
       #+ 
#{
#    name = "g14-dummy";
#    patch = "null";
#    extraConfig = ''
#                   PINCTRL_AMD y 
#                   X86_AMD_PSTATE y 
#                   AMD_PMC m
#
#                   MODULE_COMPRESS_NONE  n
#                   MODULE_COMPRESS_ZSTD y 
#
#                   LRU_GEN y 
#                   LRU_GEN_ENABLED y 
#                   LRU_GEN_STATS n 
#                   NR_LRU_GENS 7
#                   TIERS_PER_GEN 4
#
#                   INFINIBAND  n
#                   DRM_NOUVEAU  n
#                   PCMCIA_WL3501  n
#                   PCMCIA_RAYCS  n
#                   IWL3945  n
#                   IWL4965  n
#                   IPW2200  n
#                   IPW2100  n
#                   FB_NVIDIA  n
#                   SENSORS_ASUS_EC  n
#                   SENSORS_ASUS_WMI_EC n 
#
#                   RAPIDIO  n
#                   CDROM  m
#                   PARIDE  n
#
#                   CMDLINE_BOOL  y
#                   CMDLINE makepkgplaceholderyolo
#                   CMDLINE_OVERRIDE n 
#
#                   EFI_HANDOVER_PROTOCOL  y
#                   EFI_STUB y 
#
#                   HW_RANDOM_TPM n 
#
#                   SCHED_CLASS_EXT y
#                  '';
#  }
  # TODO: pass through kernelPatches
  #    allowImportFromDerivation = true;
   # };
  #pkgs.overlays = [(final: super: {makeModulesClosure = x: super.makeModulesClosure (x // {allowMissing = true; } );})];
  passthru = {
    # TODO: confirm all these stil apply
    features = {
       iwlwifi = true;
       efiBootStub = true;
       needsCifsUtils = true;
       netfilterRPFilter = true;
       ia32Emulation = true;
    };
  };

  finalKernel = lib.extendDerivation true passthru linux;
in
  finalKernel
