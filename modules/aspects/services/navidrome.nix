{
  inputs,
  ...
}:
{
  cig.services._.navidrome.nixos =
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
          containers.navidrome = {
            autoStart = true;
            containerConfig = {
              image = "docker.io/deluan/navidrome:latest";
              publishPorts = [ "4533:4533" ];
              volumes = [
                "/persistent/storage/navidrome/data:/data:Z,U"
                "/persistent/storage/navidrome/music:/music:ro,Z,U"
              ];
              environments = {
                "ND_MUSICFOLDER" = "/music";
                "ND_DATAFOLDER" = "/data";
                "ND_LOGLEVEL" = "info";
                "ND_SCANSCHEDULE" = "@every 1h";
              };
            };
            serviceConfig = {
              ExecStartPre = [
                "-${pkgs.coreutils}/bin/mkdir -p /persistent/storage/navidrome/data"
                "-${pkgs.coreutils}/bin/mkdir -p /persistent/storage/navidrome/music"
              ];
            };
          };
        };
      };
    };
}

