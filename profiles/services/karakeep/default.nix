{config,lib,...}: let cfg = config.cigneve_karakeep; in {
  options = {
    cigneve_karakeep.enable = lib.mkEnableOption "Enable personal karakeep module";
  };
  config = lib.mkIf cfg.enable {
    services.karakeep.enable = true;
  };
}
