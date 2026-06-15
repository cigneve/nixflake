{
  fileSystems."/nix".neededForBoot = true;
  fileSystems."/persistent".neededForBoot = true; # sometimes needed too

  disko.devices.nodev = {
    "/" = {
      fsType = "tmpfs";
      mountOptions = [
        "size=25%"
        "mode=755"
      ];
    };
  };

  disko.devices.disk.main = {
    device = "/dev/sda";
    type = "disk";

    content.type = "gpt";

    content.partitions.boot = {
      name = "boot";
      size = "1M";
      type = "EF02";
    };

    content.partitions.esp = {
      name = "ESP";
      size = "1G";
      type = "EF00";

      content = {
        type = "filesystem";
        format = "vfat";
        mountpoint = "/boot";
      };
    };

    content.partitions.swap = {
      name = "swap";
      size = "4G";

      content = {
        type = "swap";
        resumeDevice = true;
      };
    };

    content.partitions.root = {
      name = "root";
      size = "100%";

      content = {
        type = "btrfs";
        extraArgs = ["-f"];

        subvolumes = {
          "/persistent" = {
            mountOptions = ["subvol=persistent" "noatime"];
            mountpoint = "/persistent";
          };

          "/nix" = {
            mountOptions = ["subvol=nix" "noatime"];
            mountpoint = "/nix";
          };
        };
      };
    };
  };

  disko.devices.disk.storage = {
    device = "/dev/sdb"; # Ensure this matches your HDD
    type = "disk";
    content = {
      type = "gpt";
      partitions = {
        data = {
          name = "data";
          size = "100%";
          content = {
            type = "btrfs";
            extraArgs = ["-f"];
            # Mounts the HDD directly into your persistent storage directory
            mountpoint = "/persistent/storage"; 
          };
        };
      };
    };
  };
}
