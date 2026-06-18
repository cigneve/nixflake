{
  cig,
  lib,
  ...
}:
{
  cig.lab._.cloudflare.nixos =
    {
      config,
      pkgs,
      inputs',
      ...
    }:
    let
      UUID = "da38ced1-2335-4195-b6f7-60a99b15a878";
      cloudflared-wrapped = pkgs.writeShellScriptBin "cloudflared" ''
        exec ${pkgs.cloudflared}/bin/cloudflared --protocol http2 "$@"
      '';
    in
    {
      networking.firewall.enable = false;
      networking.firewall.extraCommands = ''
        iptables -t nat -A POSTROUTING -o ens18 -j MASQUERADE
      '';
      boot.kernel.sysctl = {
        "net.ipv4.ip_forward" = 1;
        "net.ipv6.conf.all.forwarding" = 1; # IPv6 trafiği de varsa
        "net.ipv4.conf.all.rp_filter" = 0;
        "net.ipv4.conf.default.rp_filter" = 0;
        "net.ipv4.conf.ens18.rp_filter" = 0; # ens18 sizin ağ kartınızın adı
      };
      environment.systemPackages = [ pkgs.cloudflared ];
      services.cloudflared = {
        enable = true;
        package = cloudflared-wrapped;
        certificateFile = config.sops.secrets.cloudflareCert.path;
        tunnels = {
          "${UUID}" = {
            credentialsFile = config.sops.secrets.cloudflare.path;
            default = "http_status:404";
            # originRequest.noTLSVerify = true;
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
      # services.cloudflare-warp.enable = true;

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

      sops.secrets."cloudflare" = {
        restartUnits = [ "cloudflared-tunnel-${UUID}.service" ];
      };
    };
}
