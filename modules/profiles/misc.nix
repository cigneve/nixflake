{ ... }:
{
  flake.nixosModules.misc = {
    apparmor = import ../features/misc/apparmor.nix;
    logitech = import ../features/misc/logitech.nix;
    yubikey = import ../features/misc/yubikey.nix;
    ledger = import ../features/misc/ledger.nix;
    ledgerSystem = import ../features/misc/ledger-system.nix;
    ledgerHome = import ../features/misc/ledger-home.nix;
  };
}
