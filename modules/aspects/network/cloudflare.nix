{
  cig,
  lib,
  config,
  pkgs,
  ...
}: let
  UUID = "da38ced1-2335-4195-b6f7-60a99b15a878";
  cloudflared-wrapped = pkgs.writeShellScriptBin "cloudflared" ''
    exec ${pkgs.cloudflared}/bin/cloudflared --protocol http2 "$@"
  '';
in {
  cig.lab._.cloudflare.nixos = {
    environment.systemPackages = [pkgs.cloudflared];
    services.cloudflared = {
      enable = true;
      package = cloudflared-wrapped;
      tunnels = {
        "${UUID}" = {
          credentialsFile = "${config.sops.secrets.cloudflared-creds.path}";
          default = "http_status:404";
          ingress = {
            # "immiss.aktan.org" = "http://localhost:8080";
            "mealie.aktan.org" = "http://localhost:9000";
            # "readereck.aktan.org" = "http://localhost:9005";
          };
          originRequest.noTLSVerify = true;
          warp-routing.enabled = true;
        };
      };
    };

    # Override the systemd service to force HTTP/2
    # systemd.services."cloudflared-tunnel-${UUID}" = {
    #   serviceConfig.ExecStart = lib.mkForce [
    #     "${pkgs.cloudflared}/bin/cloudflared tunnel --protocol http2 run ${UUID}"
    #   ];
    # };
    # Enable WARP as the transport layer
    services.cloudflare-warp.enable = true;

    # systemd.services."cloudflared-tunnel-${UUID}" = {
    #   # We wait for the sops secret to be decrypted before starting
    #   after = [ "sops-nix.service" ];
    #   wants = [ "sops-nix.service" ];
    #   serviceConfig = {
    #     SupplementaryGroups = [ "keys" ];
    #     ExecStart = lib.mkForce [
    #       # Note the --protocol flag BEFORE 'tunnel run'
    #       "${pkgs.cloudflared}/bin/cloudflared tunnel --protocol http2 run --credentials-file ${config.sops.secrets.cloudflared-creds.path} ${UUID}"
    #     ];
    #   };
    # };

    security.acme = {
      acceptTerms = true;
      defaults.email = "ysaktan@proton.me";
    };

    services.nginx = {
      enable = true;

      virtualHosts."mealie.aktan.org" = {
        # Only allow local connections (from the tunnel)
        listen = [
          {
            addr = "127.0.0.1";
            port = 9001;
          }
        ];
        locations."/" = {
          proxyPass = "http://127.0.0.1:9000"; # Point to your Immich Quadlet
          proxyWebsockets = true;
        };
        addSSL = true;
        enableACME = true;
      };
      virtualHosts."readereck.aktan.org" = {
        # Only allow local connections (from the tunnel)
        listen = [
          {
            addr = "127.0.0.1";
            port = 9005;
          }
        ];
        locations."/" = {
          proxyPass = "http://127.0.0.1:8000"; # Point to your Immich Quadlet
          proxyWebsockets = true;
        };
        addSSL = true;
        enableACME = true;
      };
      # virtualHosts."stalwarat.aktan.org" = {
      #   # Only allow local connections (from the tunnel)
      #   listen = [ { addr = "127.0.0.1"; port = 9006; } ];
      #   locations."/" = {
      #     proxyPass = "http://127.0.0.1:2283"; # Point to your Immich Quadlet
      #     proxyWebsockets = true;
      #   };
      # };
    };

    # services.radicale = {
    #   enable = true;
    #   settings.auth.type = "pam";
    # };

    sops.secrets."cloudflared-creds" = {
      restartUnits = ["cloudflared-tunnel-${UUID}.service"];
    };
  };
}
