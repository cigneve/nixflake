{
  lib,
  pkgs,
  ...
}: {
  imports = [./torrent.nix ./wireguard.nix ./tailscale.nix];

  networking.firewall.enable = true;
  networking.nftables.enable = true;

  networking.nameservers = ["1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one"];

  # systemd-resolved instead of dhcpcd
  networking.useDHCP = false;
  networking.dhcpcd.enable = false;
  # networking.enableIPv6 = true; # TODO
  # https://unix.stackexchange.com/questions/459991 TODO:mdns for resolved
  services.resolved = {
    enable = true;
    # dnssec = "true"; "opportunistic"
    dnssec = "false";
    fallbackDns = ["1.1.1.1#one.one.one.one" "1.0.0.1#one.one.one.one"];
    # extraConfig = ''
    #   DNSOverTLS=yes / allow-downgrade
    # '';
  };

  # Wired: systemd-networkd
  networking.useNetworkd = true;
  systemd.network.networks."40-wired" = {
    matchConfig = {Name = lib.mkForce "enp* eth*";};
    DHCP = "yes";
    networkConfig = {
      IPv6PrivacyExtensions = "yes";
    };
  };

  # TODO: Anonymize=yes ? Makes requests grow in size though

  # TODO: Not necessary since iwd handles it?
  # systemd.network.networks."40-wireless" = {
  #   matchConfig = { Name = lib.mkForce "wlp* wlan*"; };
  #   networkConfig = {
  #     IgnoreCarrierLoss="3s";
  #   };
  # };

  # Wireless: networkmanager
  networking.networkmanager = {
    enable = true;
    dns = "systemd-resolved";
  };

  networking.extraHosts = ''
    127.0.0.1 www.youtube.com
    127.0.0.1 www.reddit.com
    127.0.0.1 old.reddit.com
    127.0.0.1 twitch.tv
    127.0.0.1 instagram.com
    127.0.0.1 www.instagram.com
    127.0.0.1 gap.com.tr
    127.0.0.1 aliexpress.com
  '';
}
