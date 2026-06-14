{ ... }:
{
  flake.nixosModules.services = {
    base = import ../features/services/default.nix;
    immich = import ../features/services/immich/default.nix;
    readeck = import ../features/services/readeck/default.nix;
    mealie = import ../features/services/mealie/default.nix;
    stalwart = import ../features/services/stalwart/default.nix;
    karakeep = import ../features/services/karakeep/default.nix;
    kavita = import ../features/services/kavita/default.nix;
  };
}
