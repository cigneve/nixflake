{ ... }:
{
  flake.nixosModules.network = {
    base = import ../features/network/default.nix;
    cloudflare = import ../features/network/cloudflare.nix;
    headscale = import ../features/network/headscale.nix;
    tailscale = import ../features/network/tailscale.nix;
    torrent = import ../features/network/torrent.nix;
    wireguard = import ../features/network/wireguard.nix;
  };
}
