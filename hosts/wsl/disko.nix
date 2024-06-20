{lib,pkgs,...}:
{
  disko.devices = {
      disk = {
        sda = {
          type = "disk";
          device = "/dev/sdc";
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                label = "EFI";
                name = "ESP";
                size = "512M";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = [
                    "defaults"
                  ];
                };
              };

              # Setup as encrypted LUKS volume
              
            root={
            size = "100%";
            content = {
              type="btrfs";
              extraArgs = [ "-f" ];
              subvolumes = {
                # TODO: consider autodefrag and commit=120
                "@root" = {
                  mountpoint = "/";
                  mountOptions = ["compress=zstd:1" "noatime"];
                };
                "@home" = {
                  mountpoint = "/home";
                  mountOptions = ["compress=zstd:1" "noatime"];
                };
                "@swap" = {
                  mountpoint = "/swap";
                  mountOptions = ["compress=zstd:1" "noatime"];
                  swap = {
                    swapfile = {
                      size = "2G";
                      path = "/swapfile";
                    };
                  };
                };
                "@nix" = {
                  mountpoint = "/nix";
                  mountOptions = ["compress=zstd:1" "noatime"];
                };
                "@persist" = {
                  mountpoint = "/persist";
                  mountOptions = ["compress=zstd:1" "noatime"];
                };
                "@log" = {
                  mountpoint = "/var/log";
                  mountOptions = ["compress=zstd:1" "noatime"];
                };
              };
            };};
            };
          };
        };
      };
    };
  fileSystems."/persist".neededForBoot = true;
  fileSystems."/var/log".neededForBoot = true;
  fileSystems."/swap".neededForBoot = true;
}
