{ pkgs, flakeModules, ... }:
{
  imports = [
    flakeModules.develop.base
    ./misc/media
  ];

  environment.systemPackages =
    with pkgs;
    [
      ffmpeg
      scrcpy
      android-tools
    ]
    ++ (
      if pkgs.stdenv.isLinux then
        [ firefox ]
      else
        [ ]
    );

  fonts = {
    packages = with pkgs; [
      ubuntu-classic
      font-awesome
      noto-fonts
      noto-fonts-cjk-sans
      twemoji-color-font
      inter
      fira-code-symbols
      fira-mono
      fira
      libertine
      roboto
    ];
  };
}
