{config,lib,...}: let cfg = config.cigneve_immich; in {
  options = {
    cigneve_immich.enable = lib.mkEnableOption "Enable personal immich module";
  };

  config = lib.mkIf cfg.enable (
    {
    home-manager.users.services = {
      virtualisation.quadlet = {
          pods.immich-pod = {
            podConfig = {
              PublishPort = [ "2283:2283"];
            };
          };

          containers.immich = {
            autoStart = true;
            serviceConfig = {
              RestartSec = "10";
              Restart = "always";
            };
            containerConfig = {
              image = "ghcr.io/immich-app/immich-server:latest";
            };
          };
          containers.immich-redis = {
            containerConfig = {
              Pod
            };
          };
          volumes.immich.volumeConfig = {
            type = "bind";
            device = "/var/lib/immich";
            Label = "z";
          };
      };
    };  
  });
}
