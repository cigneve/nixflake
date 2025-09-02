# The core profile is automatically applied to all hosts.
{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [ ./linux.nix ];

  core_linux.enable = pkgs.stdenv.isLinux;

  nix.package = pkgs.nix;

  # i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = lib.mkDefault "Europe/Istanbul";

  environment = {
    systemPackages = with pkgs; [
      binutils
      coreutils
      moreutils
      curl
      dnsutils
      dosfstools
      fd
      git
      htop
      # powertop
      # iputils
      jq
      nmap
      sd
      ripgrep
      util-linux
      whois
    ];

    shellAliases = {
      n = "nix";
    };
  };

  nix = {
    gc.automatic = true;
    optimise.automatic = true;
    settings = {
      cores = 0;
      # auto-optimise-store = true;
      # sandbox = true;
      allowed-users = if pkgs.stdenv.isLinux then ["@wheel"] else ["@admin"];
      trusted-users = ["root" "@wheel"];
    };
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  # Need to configure home-manager to work with flakes
  home-manager.useGlobalPkgs = true; # is this equivalent to stateVersion 20.09?
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = {inherit inputs;};
  home-manager.backupFileExtension = "backup";

}
