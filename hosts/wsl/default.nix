{
  lib,
  pkgs,
  ...
}: let
in {
  imports = [
    ../../profiles/develop
    ../../users/baba
    ../../users/root
  ];

  networking.firewall.enable = lib.mkForce false;

  nix.maxJobs = lib.mkDefault 8;

  wsl = {
    enable = true;
    wslConf.automount.root = "/mnt";
    wslConf.interop.appendWindowsPath = true;
    wslConf.network.generateHosts = false;
    defaultUser = "baba";
    startMenuLaunchers = true;
    # Enable integration with Docker Desktop (needs to be installed)
    docker-desktop.enable = true;
  };

  environment.sessionVariables = {"COLORTERM"="truecolor";};

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
