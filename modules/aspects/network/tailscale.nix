{
  cig.network._.tailscale.nixos =
    {
      pkgs,
      ...
    }:
    {
      services.tailscale.enable = true;
      services.tailscale.useRoutingFeatures = "both";
      networking.firewall.checkReversePath = "loose";
      services.networkd-dispatcher = {
        enable = true;
        rules."50-tailscale-optimizations" = {
          onState = [ "routable" ];
          script = ''
            ${pkgs.ethtool}/bin/ethtool -K eth0 rx-udp-gro-forwarding on rx-gro-list off
          '';
        };
      };
    };
}
