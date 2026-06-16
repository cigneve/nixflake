{
  inputs,
  ...
}:
{
  cig.services._.immich.nixos =
    {
      pkgs,
      config,
      ...
    }:
    let
      envList = {
        UPLOAD_LOCATION = "/usr/src/app/upload";
        DB_DATA_LOCATION = "/var/lib/postgresql/data";
        IMMICH_VERSION = "v2";
        DB_PASSWORD = "postgres";
        DB_USERNAME = "postgres";
        DB_DATABASE_NAME = "immich";
        DB_HOSTNAME = "127.0.0.1";
        REDIS_HOSTNAME = "127.0.0.1";
      };
      databaseLocation = "/persistent/storage/immich/db";
      dataLocation = "/persistent/storage/immich/data";
      cacheLocation = "/persistent/storage/immich/cache";
      podName = "immich-pod";
    in
    {
      imports = [
        inputs.home-manager.nixosModules.home-manager
        inputs.quadlet-nix.nixosModules.quadlet
      ];

      virtualisation.quadlet.enable = true;

      home-manager.users.services = {
        imports = [
          inputs.quadlet-nix.homeManagerModules.quadlet
        ];

        virtualisation.quadlet = {
          pods."${podName}" = {
            podConfig = {
              name = podName;
              publishPorts = [ "2283:2283" ];
            };
          };

          containers = {
            immich = {
              autoStart = true;
              containerConfig = {
                image = "ghcr.io/immich-app/immich-server:v2";
                pod = "${podName}.pod";
                volumes = [
                  "${dataLocation}:/usr/src/app/upload:Z,U"
                  "/etc/localtime:/etc/localtime:ro"
                ];
                environments = envList;
              };
              serviceConfig = {
                RestartSec = "10";
                Restart = "always";
                ExecStartPre = "-${pkgs.coreutils}/bin/mkdir -p ${dataLocation}";
              };
              unitConfig = {
                after = [
                  "immich-redis.service"
                  "immich-db.service"
                ];
                requires = [
                  "immich-redis.service"
                  "immich-db.service"
                ];
              };
            };

            immich-redis = {
              containerConfig = {
                image = "docker.io/valkey/valkey:9@sha256:fb8d272e529ea567b9bf1302245796f21a2672b8368ca3fcb938ac334e613c8f";
                pod = "${podName}.pod";
              };
              serviceConfig = {
                RestartSec = "10";
                Restart = "always";
              };
            };

            immich-ml = {
              containerConfig = {
                image = "ghcr.io/immich-app/immich-machine-learning:v2";
                pod = "${podName}.pod";
                volumes = [
                  "${cacheLocation}:/cache:Z,U"
                ];
              };
              serviceConfig = {
                ExecStartPre = "-${pkgs.coreutils}/bin/mkdir -p ${cacheLocation}";
              };
            };

            immich-db = {
              containerConfig = {
                image = "ghcr.io/immich-app/postgres:14-vectorchord0.4.3-pgvectors0.2.0@sha256:bcf63357191b76a916ae5eb93464d65c07511da41e3bf7a8416db519b40b1c23";
                pod = "${podName}.pod";
                environments = envList // {
                  POSTGRES_INITDB_ARGS = "--data-checksums";
                };
                volumes = [
                  "${databaseLocation}:/var/lib/postgresql/data:Z,U"
                ];
              };
              serviceConfig = {
                ExecStartPre = "-${pkgs.coreutils}/bin/mkdir -p ${databaseLocation}";
              };
            };
          };
        };
      };
    };
}
