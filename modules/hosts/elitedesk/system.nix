{
  inputs,
  cig,
  den,
  ...
}: {
  den.hosts.x86_64-linux.elitedesk = {
    description = "Elitedesk NixOS virtual machine";
    users.baba = {};
  };

  den.aspects.elitedesk = {
    includes = with cig; [
      cig.ssh
      services
      services._.karakeep
      services._.kavita
      services._.immich
      services._.mealie
      services._.readeck
      services._.stalwart
      security._.sops
      lab._.cloudflare
      (den.batteries.vm-autologin "bab")
    ];
    nixos = {
      imports = [
        inputs.disko.nixosModules.disko
        inputs.impermanence.nixosModules.impermanence
        ./_disko.nix
      ];
      environment.persistence."/persistent" = {
        hideMounts = true;
        directories = [
          "/var/log"
          "/var/lib/bluetooth"
          "/var/lib/nixos"
          "/var/lib/systemd/coredump"
          "/etc/ssh"
          "/home" # Persists all user home folders
        ];
        files = [
          "/etc/machine-id"

        ];
      };
      boot.loader.systemd-boot.enable = true;
      system.stateVersion = "26.05";
      boot.initrd.availableKernelModules = [ "virtio_scsi" "virtio_blk" "virtio_pci" "virtio_net" ];
    };
  };
}
