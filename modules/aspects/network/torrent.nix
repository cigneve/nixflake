{
  cig,
  pkgs,
  ...
}: {
  cig.torrent.nixos = {
    environment.systemPackages = with pkgs; [
      qbittorrent
      transmission_4
      transmission_4-qt
    ];
  };
}
