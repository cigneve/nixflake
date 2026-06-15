{
  cig,
  pkgs,
  lib,
  ...
}: let
  revolver = "281733";
  berry = "3A2A4D";
  berry_fade = "5A3D6E";
  berry_dim = "47345E";
  berry_saturated = "2B1C3D";
  berry_desaturated = "886C9C";
  bubblegum = "D678B5";
  gold = "E3C0A8";
  lilac = "C7B8E0";
  mint = "7FC9AB";
  violet = "C78DFC";
  almond = "ECCDBA";
  neon = "5A4689";
in {
  cig.terminal._.ghostty = {
    homeManager = {
      pkgs,
      inputs',
      ...
    }: {
      programs = {
        ghostty = {
          enable = true;
          enableFishIntegration = true;
          package = pkgs.ghostty;
          settings = {
            command = "${pkgs.fish}/bin/fish";
            theme = "Kanagawa Wave";
            # You can override the theme by adding a file named theme
            config-file = "?theme";
          };
        };
      };
    };
  };
}
