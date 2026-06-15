{
  pkgs,
  flakeModules,
  ...
}: {
  imports = [
    flakeModules.develop.base
    ./misc/media
  ];

  environment.systemPackages = with pkgs;
    [
      ffmpeg
      scrcpy
      android-tools
    ]
    ++ (
      if pkgs.stdenv.isLinux
      then [firefox]
      else []
    );
}
