{
  pkgs,
  ...
}:{
  environment.systemPackages = with pkgs; lib.mkIf pkgs.stdenv.isLinux [
    kdePackages.kasts
  ];
}
