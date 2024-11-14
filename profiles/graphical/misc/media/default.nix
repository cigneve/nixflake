{
  pkgs,
  ...
}:{
  environment.systemPackages = with pkgs;[
    kdePackages.kasts
  ];
}
