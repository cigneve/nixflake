{cig, ...}: {
  cig.ssh.nixos = {
    services.openssh = {
      enable = true;
      ports = [777];
      settings = {
        KbdInteractiveAuthentication = false;
        PasswordAuthentication = true;
      };
    };
  };
}
