{
  cig,
  pkgs,
  ...
}: {
  cig.wireguard.nixos = {
    environment.systemPackages = with pkgs; [
      wireguard-tools
    ];
  };
}
