{ lib, config, ... }:
let
  cfg = config.cigneve_readeck;
in
{
  options = {
    cigneve_readeck.enable = lib.mkEnableOption "Enable custom readeck podman service module";
  };

  config = lib.mkIf cfg.enable { };
}
