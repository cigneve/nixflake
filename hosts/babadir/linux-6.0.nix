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
      version = "6.9";
      modDirVersion = "6.9.0";
      # modDirVersion needs to be x.y.z, will automatically add .0 if needed
#      modDirVersion =
#        if (modDirVersionArg == null)
#        then concatStringsSep "." (take 3 (splitVersion "${version}.0"))
#        else modDirVersionArg;

      # branchVersion needs to be x.y
      extraMeta.branch = versions.majorMinor version;

      src = fetchurl {
        url = "mirror://kernel/linux/kernel/v6.x/linux-${version}.tar.xz";
	sha256 = "JPoB+5icej4oRT8Rd5kWhxN2bhGcU4HawwEV8Y8mgUk=";
      };
    }
    // (args.argsOverride or {}))
