# The core profile is automatically applied to all hosts.
{
  lib,
  config,
  flakeModules,
  ...
}: let cfg = config.core_linux; in {
  imports = [
    flakeModules.develop.podman
    flakeModules.graphical.linux
  ];

  options = {
    core_linux.enable = lib.mkEnableOption "Enable core profile linux specific settings";
  };
  
  config = lib.mkIf cfg.enable{
    # i fucking hate this, how can i use attribute names that don't exist. 
    i18n.defaultLocale = "en_US.UTF-8";
    security.protectKernelImage = true;
    # OOM Handling
    services.earlyoom.enable = true;
    users.mutableUsers = false;
    programs.nix-ld.enable = true;
  };
}

