{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    kdenlive
    obs-studio
    #davinci-resolve-studio
  ];
}
