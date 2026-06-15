{
  cig,
  config,
  lib,
  serverLib,
  ...
}: {
  cig.services._.immich.homeManager = {
    pkgs,
    inputs',
    ...
  }: {
    virtualisation.quadlet = let
      envList = {
        UPLOAD_LOCATION = "./library";
        DB_DATA_LOCATION = "./postgres";
        IMMICH_VERSION = "v2";
        DB_PASSWORD = "postgres";
        DB_USERNAME = "postgres";
        DB_DATABASE_NAME = "immich";
        DB_HOSTNAME = "127.0.0.1";
        REDIS_HOSTNAME = "127.0.0.1";
      };
      databaseLocation = "/home/services/immich/db";
      dataLocation = "/home/services/immich/data";
      cacheLocation = "/home/services/immich/cache";
      podName = "immich-pod";
      inherit (config.home-manager.users.services.virtualisation.quadlet) pods;
    in {
      pods."${podName}" = {
        podConfig = {
          name = podName;
          publishPorts = ["2283:2283"];
        };
      };

      containers.immich = lib.recursiveUpdate {
        autoStart = true;
        serviceConfig = {
          RestartSec = "10";
          Restart = "always";
        };
        containerConfig = {
          image = "ghcr.io/immich-app/immich-server:v2";
          pod = pods.immich-pod.ref;
          volumes = [
            "/etc/localtime:/etc/localtime:ro"
          ];
          environments = envList;
        };
        unitConfig = {
          after = [
            "immich-redis"
            "immich-db"
          ];
          requires = [
            "immich-redis"
            "immich-db"
          ];
        };
      } (serverLib.volumeAndCreate dataLocation "/data");

      containers.immich-redis = {
        containerConfig = {
          image = "docker.io/valkey/valkey:9@sha256:fb8d272e529ea567b9bf1302245796f21a2672b8368ca3fcb938ac334e613c8f";
          pod = pods.immich-pod.ref;
        };
        serviceConfig = {
          RestartSec = "10";
          Restart = "always";
        };
      };

      containers.immich-ml = lib.recursiveUpdate {
        containerConfig = {
          image = "ghcr.io/immich-app/immich-machine-learning:v2";
          pod = pods.immich-pod.ref;
        };
      } (serverLib.volumeAndCreate cacheLocation "/cache");

      containers.immich-db = lib.recursiveUpdate {
        containerConfig = {
          image = "ghcr.io/immich-app/postgres:14-vectorchord0.4.3-pgvectors0.2.0@sha256:bcf63357191b76a916ae5eb93464d65c07511da41e3bf7a8416db519b40b1c23";
          pod = pods.immich-pod.ref;
          environments =
            envList
            // {
              POSTGRES_INITDB_ARGS = "--data-checksums";
            };
        };
      } (serverLib.volumeAndCreate databaseLocation "/var/lib/postgresql/data");
    };
  };
}
