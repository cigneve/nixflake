{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    qbittorrent
    transmission
    transmission-qt
  ];
}
