{
  cig,
  pkgs,
  ...
}:
{
  cig.wireguard.nixos =
    {
      pkgs,
      inputs',
      config,
      ...
    }:
    {

      sops.secrets.wgPrivateKey = {
        owner = "root";
        group = "root";
        mode = "0400";
      };

      environment.systemPackages = with pkgs; [
        wireguard-tools
        wstunnel # TCP/WebSocket
      ];

      boot.kernel.sysctl = {
        "net.ipv4.ip_forward" = 1;
        "net.ipv6.conf.all.forwarding" = 1;
      };


      # 4. WireGuard Arayüz Yapılandırması
      networking.wireguard.interfaces = {
        wg0 = {
          # Sunucunun tünel içindeki yerel IP adresi
          ips = [ "10.0.0.1/24" ];

          # WireGuard'ın dinleyeceği yerel UDP portu
          listenPort = 51820;

          # Sunucunun Özel Anahtarı (Private Key)
          # Güvenlik için bunu bir dosyadan okutmak (privateKeyFile) daha doğrudur.
          privateKey = config.sops.secrets.wgPrivateKey.path;

          # İstemci (Client) Tanımlamaları
          peers = [
            {
              publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOHdzNrjPUdZIj8vaJ+Y5xff81lj9nACy+CtF2YTiz9q ysaktan@mba";
              allowedIPs = [ "10.0.0.2/32" ];
            }
          ];
        };
      };
    };
}
