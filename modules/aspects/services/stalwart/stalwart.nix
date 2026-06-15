{cig, ...}: {
  cig.services._.stalwart.nixos = {
    services.stalwart-mail = {
      enable = true;
    };
  };
}
