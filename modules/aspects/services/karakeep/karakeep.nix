{
  cig,
  config,
  lib,
  ...
}: {
  cig.services._.karakeep.nixos = {
    services.karakeep.enable = true;
  };
}
