{
  disko.devices = {
    disk = {
      root = {
        device = "/dev/disk/by-id/ata-SanDisk_SDSSDA240G_161956446109";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              name = "ESP";
              size = "1024M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                settings = {
                  allowDiscards = true;
                };
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ];
                  subvolumes = {
                    "/root" = {
                      mountpoint = "/";
                    };
                    "/nix" = {
                      mountOptions = [
                        "subvol=nix"
                        "noatime"
                      ];
                      mountpoint = "/nix";
                    };
                    "/persist" = {
                      mountOptions = [
                        "subvol=persist"
                        "noatime"
                      ];
                      mountpoint = "/persist";
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
}
