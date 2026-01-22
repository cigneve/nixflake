{...}: {
  users.users.immich_user = {
    isSystemUser = true;
    group = "immich_group";
    uid = 1001; # Matches the UID in .env
  };
  users.groups.immich_group.gid = 1001;
}
