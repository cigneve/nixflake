{ pkgs, ... }:
{
  home-manager.users.baba = {
    home.packages = with pkgs; [ ledger-live-desktop ];
  };
}
