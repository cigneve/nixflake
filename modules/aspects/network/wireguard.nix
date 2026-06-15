{
  cig,
  pkgs,
  ...
}: {
  cig.wireguard.nixos = {
    pkgs,
    inputs',
    ...
  }: {
    environment.systemPackages = with pkgs; [
      wireguard-tools
    ];
  };
}
