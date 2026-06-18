{
  inputs,
  ...
}:
{
  cig.services._.slskd.nixos =
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
          containers.slskd = {
            autoStart = true;
            containerConfig = {
              image = "docker.io/slskd/slskd:latest";
              publishPorts = [ 
                "5030:5030"      # Web UI HTTP port
                "50300:50300"    # Soulseek incoming listening port
              ];
              volumes = [
                "/persistent/storage/slskd/app:/app:Z,U"
                # Exposes the shared music folder so slskd can download to it and read shares
                "/persistent/storage/navidrome/music:/music:Z,U"
              ];
              environments = {
                "SLSKD_REMOTE_CONFIGURATION" = "true";
                # Points slskd to look inside the mounted volume for shares
                "SLSKD_SHARED_DIR" = "/music";
              };
            };
            serviceConfig = {
              ExecStartPre = [
                "-${pkgs.coreutils}/bin/mkdir -p /persistent/storage/slskd/app"
                "-${pkgs.coreutils}/bin/mkdir -p /persistent/storage/navidrome/music"
              ];
            };
          };
        };
      };
    };
}

