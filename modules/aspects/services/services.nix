{
  cig,
  pkgs,
  config,
  ...
}: {
  cig.services.nixos = {
    pkgs,
    inputs',
    ...
  }: {
    users.users.services = {
      isNormalUser = true;
      group = "services_group";
      extraGroups = [
        "docker"
        "podman"
        "wheel"
      ];
      uid = 1001; # Matches the UID in .env
      linger = true;
      autoSubUidGidRange = true;
    };
    users.groups.services_group.gid = 1001;
    # home-manager.users.services.home.stateVersion = "24.05";
    _module.args = {
      serverLib = {
        volumeAndCreate = source: dest: {
          containerConfig.volumes = ["${source}:${dest}"];
          serviceConfig.ExecStartPre = ["${pkgs.coreutils}/bin/mkdir -p ${source}"];
        };
      };
    };
  };
}
