{cig, ...}: {
  cig.services._.stalwart.nixos = {
    pkgs,
    inputs',
    ...
  }: {
    services.stalwart= {
      enable = true;
      stateVersion = "26.05";
    };
  };
}
