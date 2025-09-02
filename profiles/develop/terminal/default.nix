{
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
  programs =
    if pkgs.stdenv.isLinux
    then {
      foot.enable = true;
      foot.settings = {
        colors = {
          foreground = lilac;
          background = revolver;
          regular0 = berry_saturated;
          regular1 = bubblegum;
          regular2 = mint;
          regular3 = gold;
          regular4 = berry_fade;
          regular5 = berry_desaturated;
          regular6 = neon;
          regular7 = almond;
          bright0 = berry_saturated;
          bright1 = bubblegum;
          bright2 = mint;
          bright3 = gold;
          bright4 = berry_fade;
          bright5 = berry_desaturated;
          bright6 = lilac;
          bright7 = almond;
        };
      };
    }
    else {
      ghostty = {
        enable = true;
        enableFishIntegration = true;
        package = pkgs.ghostty-bin;
        settings = {
          command = "${pkgs.fish}/bin/fish";
          theme = "Kanagawa Wave";
          custom-shader = "~/bettercrt.glsl";
        };
      };
    };
}
