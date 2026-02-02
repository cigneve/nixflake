{config,...}:{
  imports = [./readeck ./mealie ./stalwart ./karakeep];
  config =  {
    users.users.services = {
      isSystemUser = true;
      group = "services_group";
      extraGroups = ["docker" "podman"];
      uid = 1001; # Matches the UID in .env
      linger = true;
      autoSubUidGidRange = true;
    };
    users.groups.services_group.gid = 1001;
  };
}
