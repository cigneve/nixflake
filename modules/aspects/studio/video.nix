{
  cig,
  pkgs,
  ...
}: {
  cig.videoEditing.nixos = {
    pkgs,
    inputs',
    ...
  }: {
    environment.systemPackages = with pkgs; [
      kdePackages.kdenlive
      obs-cli
      (pkgs.wrapOBS {
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          obs-backgroundremoval
          obs-pipewire-audio-capture
          obs-source-record
          obs-websocket
        ];
      })
    ];
  };
}
