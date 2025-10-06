{
  config,
  pkgs,
  lib,
  home,
  ...
}: {
  imports = [./homebrew.nix];

  # System Settings
  system.defaults = {
    CustomUserPreferences = {
      "org.hammerspoon.Hammerspoon" = {
        MJConfigFile = ./hammerspoon-config;
      };
    };
  };

  # Home-manager app linking
  # we're injecting home-manager apps into the path that is copied in an activation script
  # TODO: deprecate in favor of https://github.com/nix-community/home-manager/pull/7915
  system.build.applications = lib.mkForce (
    pkgs.buildEnv {
      name = "nix-apps";
      pathsToLink = "/Applications";
      paths = config.environment.systemPackages ++ (lib.concatMap (user: user.home.packages) (lib.attrsets.attrValues config.home-manager.users));
    }
  );
}
