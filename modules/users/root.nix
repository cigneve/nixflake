{den,lib, ...}: {
  # users.users.root.password = "";
  den.aspects.root.nixos = {lib,...}:
  {users.users.root.hashedPassword = lib.mkForce "$6$TcpkJpYJiFiP.7ZF$.dg/CXEqaC646ad6m3oMIZHwCDZVjzydFebiA/K8HN4MFo0NGk7NmmnUqfS/4jSJLpKjO7ZL7g9iiIC3.AJI0.";};
}
