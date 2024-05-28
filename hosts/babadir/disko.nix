{lib,pkgs,...}:
{
  disko.devices = {
      disk = {
        nvme0n1 = {
          type = "disk";
          device = "/dev/nvme0n1";
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
              luks = {
                size = "100%";
                content = {
                  type = "luks";
                  name = "cryptroot";
                  extraOpenArgs = [
                    "--allow-discards"
                    "--perf-no_read_workqueue"
                    "--perf-no_write_workqueue"
                  ];
                  # https://0pointer.net/blog/unlocking-luks2-volumes-with-tpm2-fido2-pkcs11-security-hardware-on-systemd-248.html
                  settings = {crypttabExtraOpts = ["fido2-device=auto" "token-timeout=10"];};
                  content = {
                    type = "btrfs";
                    extraArgs = ["-L" "nixos"]; # -f ?
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
                            size = "10G";
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
                  };
                };
              };
            };
          };
        };
      };
    };
  fileSystems."/persist".neededForBoot = true;
  fileSystems."/var/log".neededForBoot = true;
  fileSystems."/swap".neededForBoot = true;
}
