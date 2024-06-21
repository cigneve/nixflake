{
  config,
  pkgs,
  lib,
  ...
}: {
  # Don't block boot/nixos-rebuild on all interfaces, wired usually unplugged
  systemd.network.wait-online.enable = false;
  # systemd.network.wait-online.timeout = 10;
  # systemd.network.wait-online.anyInterface = true;

  environment.systemPackages = with pkgs; [
    acpi
    lm_sensors
    wirelesstools # TODO: probably unnecessary with iwd
  ];

  # remap caps to escape/ctrl on built-in keyboard.
  # TODO: Convert S to meta/alt
  environment.etc."dual-function-keys.yaml".text = ''
    TIMING:
      DOUBLE_TAP_MILLISEC: 0

    MAPPINGS:
      - KEY: KEY_CAPSLOCK
        TAP: KEY_ESC
        HOLD: KEY_LEFTCTRL
  '';
  services.interception-tools = {
    enable = true;
    plugins = [pkgs.interception-tools-plugins.dual-function-keys];
    udevmonConfig = ''
      - JOB: "${pkgs.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs.interception-tools-plugins.dual-function-keys}/bin/dual-function-keys -c /etc/dual-function-keys.yaml | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
        DEVICE:
          EVENTS:
            EV_KEY: [KEY_CAPSLOCK]
    '';
  };

  services.upower.enable = lib.mkDefault true;

  # --adaptive by default
  services.thermald.enable = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;

  # to enable brightness keys
  programs.light.enable = true;

  # sound.mediaKeys = lib.mkIf (!config.hardware.pulseaudio.enable) {
  #   enable = true;
  #   volumeStep = "1dB";
  # };

  # better timesync for unstable internet connections
  services.chrony.enable = true;
  services.timesyncd.enable = false;

  # power management features
  # services.tlp.enable = true;
  # services.tlp.settings = {
  #   USB_ALLOWLIST="32ac:0002"; # Suspend Framework HDMI card
  #   # USB_EXCLUDE_PHONE = 1;
  # };
  # services.tlp.extraConfig = ''
  #   CPU_SCALING_GOVERNOR_ON_AC="performance";
  #   CPU_SCALING_GOVERNOR_ON_BAT="schedutil";
  #   CPU_HWP_ON_AC="performance";
  # '';
  services.logind.lidSwitch = "suspend";
}
