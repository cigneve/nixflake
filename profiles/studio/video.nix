{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    kdenlive
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
    #davinci-resolve-studio
  ];
}
