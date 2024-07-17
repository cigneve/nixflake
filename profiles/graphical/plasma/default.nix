{pkgs,
lib,
...}:
{
  environment.systemPackages = with pkgs;[
    kdeconnect
  ];

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    # plasma-browser-integration
    konsole
    oxygen
    kate
    elisa
  ];

  services= {
    # Scaling factor for fonts and graphical elements on the screen
    xserver = {
      dpi = 98;
      enable = true;
      exportConfiguration = true;
    };
    libinput.enable = true;
    desktopManager = {
      plasma6.enable = true;

    };
    displayManager = {
      sddm = {
        enable = true;
        autoNumlock = true;

        settings = {
          Theme = {
            # CursorTheme = "layan-border_cursors";

          };
        };
        # theme = "breeze";
      };
      defaultSession = "plasma";
    };

    # ---------------------------------------------------------------------
    # Video settings that go hand-in-hand with OpenGL
    # ---------------------------------------------------------------------
  };
}