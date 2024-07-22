{pkgs,...}:
{
  system.environmentPackages = with pkgs;[
    davinci-resolve-studio
  ];
}
