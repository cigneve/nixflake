{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    kdenlive
    #davinci-resolve-studio
  ];
}
