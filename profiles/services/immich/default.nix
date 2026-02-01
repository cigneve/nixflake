{config,lib,...}: let cfg = config.cigneve_immich; in {
  options = {
    cigneve_immich.enable = lib.mkEnableOption "Enable personal immich module";
  };
  config = lib.mkIf cfg.enable {
    users.users.immich_user = {
      isNormalUser = true;
      group = "immich_group";
      extraGroups = ["docker" "podman"];
      hashedPassword = "$6$QtDhkTQwPH8CRlwc$/kiKYt8tAuW52UdQCwPTs9rACELxSGdcBieEfByDZU/9ODIG8M4HP7yQ0LrV8gyGSsCx9jsYJfRqVfdjfXMwB.";
      uid = 1001; # Matches the UID in .env
    };
    users.groups.immich_group.gid = 1001;
  };
}
