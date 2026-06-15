{
  cig,
  lib,
  pkgs,
  ...
}: {
  cig.podman.nixos = {
    pkgs,
    inputs',
    ...
  }: {
    virtualisation.docker.enable = false;
    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
      dockerSocket.enable = true;
      # defaultNetwork.settings = lib.mkForce { };
      defaultNetwork.settings.dns_enabled = true;
    };
    virtualisation.oci-containers.backend = "podman";

    # TODO  users.users.baba.extraGroups = ["podman"];
  };
}
