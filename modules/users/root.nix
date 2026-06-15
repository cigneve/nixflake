{den,lib, ...}: {
  # users.users.root.password = "";
  den.aspects.root.nixos = {lib,...}:
  {users.users.root.hashedPassword = lib.mkForce "$y$j9T$IKcCOepvBwymNAVduT9aA.$sVQD54FZP3vmDawc.CZSrfhE9TVzNea5N69IJUZUPm.";};
}
