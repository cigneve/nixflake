{cig, ...}: {
  cig.ssh.nixos = {
    pkgs,
    inputs',
    ...
  }: {
    services.openssh = {
      enable = true;
      ports = [777];
      settings = {
        KbdInteractiveAuthentication = false;
        PasswordAuthentication = true;
        X11Forwarding = true;
      };
    };
  };
}
