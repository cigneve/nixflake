{
  lib,
  buildPackages,
  fetchurl,
  perl,
  buildLinux,
  nixosTests,
  modDirVersionArg ? null,
  ...
} @ args:
with lib;
  buildLinux (args
    // rec {
      version = "6.5";

      # modDirVersion needs to be x.y.z, will automatically add .0 if needed
      modDirVersion =
        if (modDirVersionArg == null)
        then concatStringsSep "." (take 3 (splitVersion "${version}.0"))
        else modDirVersionArg;

      # branchVersion needs to be x.y
      extraMeta.branch = versions.majorMinor version;

      src = fetchurl {
        url = "mirror://kernel/linux/kernel/v6.x/linux-${version}.tar.xz";
	sha256 = "7a574bbc20802ea76b52ca7faf07267f72045e861b18915c5272a98c27abf884";
      };
    }
    // (args.argsOverride or {}))
