{cig, ...}: {
  cig.services._.kavita.nixos = {
    pkgs,
    inputs',
    config,
    ...
  }: {
    services.kavita.enable = true;
    services.kavita.tokenKeyFile = config.sops.secrets.kavitaToken.path;
  };
}
