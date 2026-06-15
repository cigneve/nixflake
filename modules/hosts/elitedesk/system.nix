{
  cig,
  den,
  ...
}: {
  den.hosts.x86_64-linux.elitedesk = {
    description = "Elitedesk NixOS virtual machine";
    users.bab = {};
  };

  den.aspects.elitedesk = {
    includes = with cig; [
      services
      services._.immich
      services._.karakeep
      services._.kavita
      services._.mealie
      services._.readeck
      services._.stalwart
      (den.batteries.vm-autologin "bab")
    ];
    nixos = {
      boot.loader.systemd-boot.enable = true;
      system.stateVersion = "26.05";
    };
  };
}
