{
  cig,
  config,
  lib,
  ...
}: {
  cig.services._.mealie.nixos = {
    services.mealie = {
      enable = true;
    };
  };
}
