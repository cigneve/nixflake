{
  pkgs,
  lib,
  ...
}: {
  cig.sound._.pipewire.nixos.services.pipewire = {
    enable = true;

    wireplumber = {
      enable = true;
      configPackages = [
        (pkgs.writeTextDir "share/wireplumber/wireplumber.conf.d/10-control.conf" ''
          node.features.audio.control-port: true
        '')
      ];
    };

    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
}
