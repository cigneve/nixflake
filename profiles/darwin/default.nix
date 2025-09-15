{
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

}
