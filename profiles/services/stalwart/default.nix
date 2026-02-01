{config,lib,...}: let cfg = config.cigneve_stalwart; in {
  options = {
    cigneve_stalwart.enable = lib.mkEnableOption "Enable personal mealie module";
  };
  config = lib.mkIf cfg.enable {
    services.stalwart-mail = {
      enable = true;
    };
  };
}
