{cig, ...}: {
  cig.zoxide.homeManager = {
    pkgs,
    inputs',
    ...
  }: {
    programs.zoxide = {
      enable = true;
    };
  };
}
