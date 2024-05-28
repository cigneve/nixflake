{pkgs, ...}: {
  imports = [./fish ./podman];
  home-manager.users.baba = {
    # TODO: zellij
    imports = [ ./wezterm];
  };

  # qmk rules
  services.udev.extraRules = ''
    # UDEV rules for Teensy USB devices
    ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", ENV{ID_MM_DEVICE_IGNORE}="1"
    ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789A]?", ENV{MTP_NO_PROBE}="1"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789ABCD]?", MODE:="0666"
    KERNEL=="ttyACM*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", MODE:="0666"
  '';

  environment = {
    sessionVariables = {
      PAGER = "less";
      LESS = "-iFJMRWX -z-4 -x4";
      HELIX_RUNTIME = "${pkgs.helix}/lib/runtime";
      EDITOR = "${pkgs.helix}/bin/hx";
      VISUAL = "${pkgs.helix}/bin/hx";
      # TERMINAL = "alacritty";
      # BROWSER = "firefox-developer-edition";
    };

    systemPackages = with pkgs; [
      gnumake
      file
      # git-crypt
      gnupg
      less
      wget
      rsync
      picocom

      helix
      lf

      dua # disk usage
      pass
      tokei
      iptables
      tcpdump

      graphviz
      imagemagick

      # meli

      # tamsyn
      # curie

      usbutils
      pciutils

      cargo-outdated
      zola

      asciinema

      gh # TODO: move to git profile

      libqalculate

      bandwhich
      jless
      xh
      xplr
      bottom
    ];

    # TODO: mutt / aerc
  };

  documentation.dev.enable = true;

  # programs.mosh.enable = true;
  # programs.firejail.enable = true;
}
