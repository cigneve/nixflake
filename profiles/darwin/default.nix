{
  ...
}: {
  imports = [./homebrew.nix];

  services.karabiner-elements = {
    enable = true;
  };

  # System Settings
  system.defaults = {
    CustomUserPreferences = {
      "org.hammerspoon.Hammerspoon" = {
        MJConfigFile = ./hammerspoon-config;
      };
    };
  };

}
