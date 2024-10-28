{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    kdenlive
    (pkgs.wrapOBS {
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          obs-backgroundremoval
          obs-pipewire-audio-capture
          obs-source-record
        ];
      })
    #davinci-resolve-studio
  ];
}
