{cig, ...}: {
  cig.services._.stalwart.nixos = {
    pkgs,
    inputs',
    ...
  }: {
    services.stalwart-mail = {
      enable = true;
    };
  };
}
