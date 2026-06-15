{
  cig,
  config,
  lib,
  ...
}: {
  cig.services._.mealie.nixos = {
    pkgs,
    inputs',
    ...
  }: {
    services.mealie = {
      enable = true;
    };
  };
}
