{
  cig,
  lib,
  config,
  ...
}: {
  cig.services._.readeck.nixos.homeManager = {
    pkgs,
    inputs',
    ...
  }: {
    services = {
      virtualisation.quadlet = {
        containers.readeck = {
          autoStart = true;
          containerConfig = {
            image = "codeberg.org/readeck/readeck:latest";
            publishPorts = ["8000:8000"];
            volumes = [
              "/var/lib/readeck:/readeck:Z"
            ];
          };
          serviceConfig = {
            environment = [
              "READECK_SERVER_HOST=0.0.0.0"
              "READECK_SERVER_PORT=8000"
              "READECK_LOG_LEVEL=info"
            ];
          };
        };
      };
    };
  };
}
