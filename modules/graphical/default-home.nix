{ ... }:
{
  home-manager.users.baba = {
    imports = [
      ./misc/mpv
      ./zathura
    ];
  };
}
