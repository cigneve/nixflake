{pkgs, ...}: {
  imports = [./udev.nix];

  # hardware.opengl.driSupport32Bit = true;
  hardware.graphics.enable = true;
  hardware.pulseaudio.support32Bit = true;

  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    protontricks
    # proton-caller
    # python3
    # retroarchBare
    # pcsx2
    # qjoypad
    vulkan-tools
    vulkan-loader
  ];

  # services.wii-u-gc-adapter.enable = true;

  # fps games on laptop need this
  # services.xserver.libinput.disableWhileTyping = false;

  # better for steam proton games
  systemd.extraConfig = "DefaultLimitNOFILE=1048576";

  # improve wine performance
  # environment.sessionVariables = { WINEDEBUG = "-all,fixme-all"; };
}
