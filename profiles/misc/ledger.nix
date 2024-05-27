{pkgs, ...}: {
  hardware.ledger.enable = true;

  home-manager.users.baba = {pkgs, ...}: {
    home.packages = with pkgs; [ledger-live-desktop];
  };
}
