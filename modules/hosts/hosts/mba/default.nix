{
  lib,
  pkgs,
  flakeModules,
  ...
}:
{
  imports = [
    flakeModules.develop.base
    # ../../profiles/network # sets up wireless
    flakeModules.graphical.base
    flakeModules.darwin.base
    # ../../profiles/misc/yubikey.nix
    # ../../profiles/studio
    ../../users/baba
  ];

  system.primaryUser = "ysaktan";

  # nix.maxJobs = lib.mkDefault 8;
  # nix.systemFeatures = [ "gccarch-haswell" ];


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = 6; # Did you read the comment?
}
