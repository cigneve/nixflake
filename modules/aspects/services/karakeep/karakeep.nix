{
  cig,
  config,
  lib,
  ...
}: {
  cig.services._.karakeep.nixos = {
    pkgs,
    inputs',
    ...
  }: {
    services.karakeep.enable = true;
  };
}
