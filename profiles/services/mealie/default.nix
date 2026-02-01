{config,lib,...}: let cfg = config.cigneve_mealie; in {
  options = {
    cigneve_mealie.enable = lib.mkEnableOption "Enable personal mealie module";
  };
  config = lib.mkIf cfg.enable {
    services.mealie = {
      enable = true;
    };
  };
}
