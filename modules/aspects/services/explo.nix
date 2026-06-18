{
  inputs,
  ...
}:
{
  cig.services._.explo.nixos =
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
          containers.explo = {
            autoStart = true;
            containerConfig = {
              image = "ghcr.io/lumepart/explo:latest";
              publishPorts = [ "7288:7288" ];
              volumes = [
                "/persistent/storage/explo/config:/opt/explo/config:Z,U"
                # Mounts inside the shared Navidrome music directory so Navidrome can read the downloads
                "/persistent/storage/navidrome/music/explo:/data:Z,U"
                "/persistent/storage/slskd/downloads:/slskd:Z,U"
              ];
              environments = {
                "EXECUTE_ON_START" = "false";
              };
            };
            serviceConfig = {
              ExecStartPre = [
                "-${pkgs.coreutils}/bin/mkdir -p /persistent/storage/explo/config"
                "-${pkgs.coreutils}/bin/mkdir -p /persistent/storage/navidrome/music/explo"
                "-${pkgs.coreutils}/bin/mkdir -p /persistent/storage/slskd/downloads"
              ];
            };
          };
        };
      };
    };
}

