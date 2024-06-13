{
  lib,
  buildPackages,
  fetchurl,
  perl,
  buildLinux,
  nixosTests,
  modDirVersionArg ? null,
pkgs,
  ...
} @ args:
with lib;
  buildLinux (args
    // rec {

      # Temporary Hack
      # features = {
      #    iwlwifi = true;
      #    efiBootStub = true;
      #    needsCifsUtils = true;
      #    netfilterRPFilter = true;
      #    ia32Emulation = true;
      # };

      version = "6.9.3";
      modDirVersion = "6.9.3";
      # modDirVersion needs to be x.y.z, will automatically add .0 if needed
#      modDirVersion =
#        if (modDirVersionArg == null)
#        then concatStringsSep "." (take 3 (splitVersion "${version}.0"))
#        else modDirVersionArg;

      # branchVersion needs to be x.y
      extraMeta.branch = versions.majorMinor version;

      src = fetchurl {
        url = "mirror://kernel/linux/kernel/v6.x/linux-${version}.tar.xz";
	# sha256 = "";
	sha256 = "wyHEZAE2h3T8I29XCVsgWl2ldBX5pgCAGJAvn9Xt364=";
      };
    }
    // (args.argsOverride or {}))
