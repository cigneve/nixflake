{
  inputs,
  ...
}:
{
  cig.services._.readeck.nixos =
    {
      pkgs,
      ...
    }:
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
          containers.readeck = {
            autoStart = true;
            containerConfig = {
              image = "codeberg.org/readeck/readeck:latest";
              publishPorts = [ "8000:8000" ];
              volumes = [
                "/persistent/storage/readeck:/readeck:Z,U"
              ];
              environments = {
                "READECK_SERVER_HOST" = "0.0.0.0";
                "READECK_SERVER_PORT" = "8000";
                "READECK_LOG_LEVEL" = "info";
              };
            };
            serviceConfig = {
              ExecStartPre = "-${pkgs.coreutils}/bin/mkdir -p /persistent/storage/readeck";
            };
          };
        };
      };
    };
}
