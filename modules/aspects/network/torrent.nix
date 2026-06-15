{
  cig,
  pkgs,
  ...
}: {
  cig.torrent.nixos = {
    pkgs,
    inputs',
    ...
  }: {
    environment.systemPackages = with pkgs; [
      qbittorrent
      transmission_4
      transmission_4-qt
    ];
  };
}
