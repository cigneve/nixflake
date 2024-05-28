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
  linux = pkgs.linuxKernel.kernels.linux_zen;
  # linux = pkgs.linuxPackages_latest;
   #linux = pkgs.callPackage ./linux-6.0.nix {};

  kernel =
    linuxManualConfig {
      inherit (linux) stdenv version modDirVersion src;
      inherit lib;
      configfile = ./kernel.config;
      kernelPatches = [
      ]; # TODO: pass through kernelPatches
      allowImportFromDerivation = true;
    };
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

  finalKernel = lib.extendDerivation true passthru kernel;
in
  finalKernel
