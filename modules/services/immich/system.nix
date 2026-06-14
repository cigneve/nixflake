{ lib, config, ... }:
let
  cfg = config.cigneve_immich;
in
{
  options = {
    cigneve_immich.enable = lib.mkEnableOption "Enable personal immich module";
  };

  config = lib.mkIf cfg.enable { };
}
