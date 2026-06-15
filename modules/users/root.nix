{den,lib, ...}: {
  # users.users.root.password = "";
  den.aspects.root.nixos = {lib,...}:
  {users.users.root.hashedPassword = lib.mkForce "$y$j9T$9gXgYwkSGmkBZFHCL81gC1$FbetOSNYOC7rw546mRw6dZxlmgL.v0HDIZa/mWCbkQ0";};
}
