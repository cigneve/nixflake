{
  inputs,
  ...
}:
{
  # ==========================================
  # JELLYFIN - Media Server
  # ==========================================
  cig.services._.jellyfin.nixos = { pkgs, ... }: {
    imports = [
      inputs.home-manager.nixosModules.home-manager
      inputs.quadlet-nix.nixosModules.quadlet
    ];
    virtualisation.quadlet.enable = true;
    home-manager.users.services.imports = [ inputs.quadlet-nix.homeManagerModules.quadlet ];
    home-manager.users.services.virtualisation.quadlet.containers.jellyfin = {
      autoStart = true;
      containerConfig = {
        image = "lscr.io/linuxserver/jellyfin:latest";
        publishPorts = [ "8096:8096" ];
        # Optional: Add "/dev/dri:/dev/dri" under `devices = [ ... ]` for hardware transcoding
        volumes = [
          "/persistent/storage/jellyfin/config:/config:Z,U"
          "/persistent/storage/media:/data:Z,U" # Shared media root
        ];
        environments = { "PUID" = "1000"; "PGID" = "100"; "TZ" = "Etc/UTC"; };
      };
      serviceConfig = {
        ExecStartPre = [
          "-${pkgs.coreutils}/bin/mkdir -p /persistent/storage/jellyfin/config"
          "-${pkgs.coreutils}/bin/mkdir -p /persistent/storage/media"
        ];
      };
    };
  };

  # ==========================================
  # PROWLARR - Indexer Manager
  # ==========================================
  cig.services._.prowlarr.nixos = { pkgs, ... }: {
    imports = [ inputs.home-manager.nixosModules.home-manager inputs.quadlet-nix.nixosModules.quadlet ];
    virtualisation.quadlet.enable = true;
    home-manager.users.services.imports = [ inputs.quadlet-nix.homeManagerModules.quadlet ];
    home-manager.users.services.virtualisation.quadlet.containers.prowlarr = {
      autoStart = true;
      containerConfig = {
        image = "lscr.io/linuxserver/prowlarr:latest";
        publishPorts = [ "9696:9696" ];
        volumes = [ "/persistent/storage/prowlarr/config:/config:Z,U" ];
        environments = { "PUID" = "1000"; "PGID" = "100"; "TZ" = "Etc/UTC"; };
      };
      serviceConfig = {
        ExecStartPre = [ "-${pkgs.coreutils}/bin/mkdir -p /persistent/storage/prowlarr/config" ];
      };
    };
  };

  # ==========================================
  # RADARR - Movies
  # ==========================================
  cig.services._.radarr.nixos = { pkgs, ... }: {
    imports = [ inputs.home-manager.nixosModules.home-manager inputs.quadlet-nix.nixosModules.quadlet ];
    virtualisation.quadlet.enable = true;
    home-manager.users.services.imports = [ inputs.quadlet-nix.homeManagerModules.quadlet ];
    home-manager.users.services.virtualisation.quadlet.containers.radarr = {
      autoStart = true;
      containerConfig = {
        image = "lscr.io/linuxserver/radarr:latest";
        publishPorts = [ "7878:7878" ];
        volumes = [
          "/persistent/storage/radarr/config:/config:Z,U"
          "/persistent/storage/media:/data:Z,U"
        ];
        environments = { "PUID" = "1000"; "PGID" = "100"; "TZ" = "Etc/UTC"; };
      };
      serviceConfig = {
        ExecStartPre = [ "-${pkgs.coreutils}/bin/mkdir -p /persistent/storage/radarr/config" "-${pkgs.coreutils}/bin/mkdir -p /persistent/storage/media" ];
      };
    };
  };

  # ==========================================
  # SONARR - TV Shows
  # ==========================================
  cig.services._.sonarr.nixos = { pkgs, ... }: {
    imports = [ inputs.home-manager.nixosModules.home-manager inputs.quadlet-nix.nixosModules.quadlet ];
    virtualisation.quadlet.enable = true;
    home-manager.users.services.imports = [ inputs.quadlet-nix.homeManagerModules.quadlet ];
    home-manager.users.services.virtualisation.quadlet.containers.sonarr = {
      autoStart = true;
      containerConfig = {
        image = "lscr.io/linuxserver/sonarr:latest";
        publishPorts = [ "8989:8989" ];
        volumes = [
          "/persistent/storage/sonarr/config:/config:Z,U"
          "/persistent/storage/media:/data:Z,U"
        ];
        environments = { "PUID" = "1000"; "PGID" = "100"; "TZ" = "Etc/UTC"; };
      };
      serviceConfig = {
        ExecStartPre = [ "-${pkgs.coreutils}/bin/mkdir -p /persistent/storage/sonarr/config" ];
      };
    };
  };

  # ==========================================
  # LIDARR - Music
  # ==========================================
  cig.services._.lidarr.nixos = { pkgs, ... }: {
    imports = [ inputs.home-manager.nixosModules.home-manager inputs.quadlet-nix.nixosModules.quadlet ];
    virtualisation.quadlet.enable = true;
    home-manager.users.services.imports = [ inputs.quadlet-nix.homeManagerModules.quadlet ];
    home-manager.users.services.virtualisation.quadlet.containers.lidarr = {
      autoStart = true;
      containerConfig = {
        image = "lscr.io/linuxserver/lidarr:latest";
        publishPorts = [ "8686:8686" ];
        volumes = [
          "/persistent/storage/lidarr/config:/config:Z,U"
          "/persistent/storage/media:/data:Z,U"
        ];
        environments = { "PUID" = "1000"; "PGID" = "100"; "TZ" = "Etc/UTC"; };
      };
      serviceConfig = {
        ExecStartPre = [ "-${pkgs.coreutils}/bin/mkdir -p /persistent/storage/lidarr/config" ];
      };
    };
  };

  # ==========================================
  # READARR - Books
  # ==========================================
  cig.services._.readarr.nixos = { pkgs, ... }: {
    imports = [ inputs.home-manager.nixosModules.home-manager inputs.quadlet-nix.nixosModules.quadlet ];
    virtualisation.quadlet.enable = true;
    home-manager.users.services.imports = [ inputs.quadlet-nix.homeManagerModules.quadlet ];
    home-manager.users.services.virtualisation.quadlet.containers.readarr = {
      autoStart = true;
      containerConfig = {
        # Note: linuxserver provides readarr mostly via the :develop or :latest tag
        image = "lscr.io/linuxserver/readarr:latest";
        publishPorts = [ "8787:8787" ];
        volumes = [
          "/persistent/storage/readarr/config:/config:Z,U"
          "/persistent/storage/media:/data:Z,U"
        ];
        environments = { "PUID" = "1000"; "PGID" = "100"; "TZ" = "Etc/UTC"; };
      };
      serviceConfig = {
        ExecStartPre = [ "-${pkgs.coreutils}/bin/mkdir -p /persistent/storage/readarr/config" ];
      };
    };
  };

  # ==========================================
  # BAZARR - Subtitles
  # ==========================================
  cig.services._.bazarr.nixos = { pkgs, ... }: {
    imports = [ inputs.home-manager.nixosModules.home-manager inputs.quadlet-nix.nixosModules.quadlet ];
    virtualisation.quadlet.enable = true;
    home-manager.users.services.imports = [ inputs.quadlet-nix.homeManagerModules.quadlet ];
    home-manager.users.services.virtualisation.quadlet.containers.bazarr = {
      autoStart = true;
      containerConfig = {
        image = "lscr.io/linuxserver/bazarr:latest";
        publishPorts = [ "6767:6767" ];
        volumes = [
          "/persistent/storage/bazarr/config:/config:Z,U"
          "/persistent/storage/media:/data:Z,U"
        ];
        environments = { "PUID" = "1000"; "PGID" = "100"; "TZ" = "Etc/UTC"; };
      };
      serviceConfig = {
        ExecStartPre = [ "-${pkgs.coreutils}/bin/mkdir -p /persistent/storage/bazarr/config" ];
      };
    };
  };
}
