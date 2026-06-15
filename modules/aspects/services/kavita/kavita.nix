{cig, ...}: {
  cig.services._.kavita.nixos = {
    pkgs,
    inputs',
    ...
  }: {
    services.kavita.enable = true;
  };
}
