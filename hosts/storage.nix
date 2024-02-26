{ home-user, ... }:

{
  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/48444e2c-e8f0-4a45-bfea-99ed67fb9ac7";
      fsType = "btrfs";
      options = [ "noatime" "lazytime" "compress=zstd" ];
    };

  fileSystems."/mnt/hdd" =
    { device = "/dev/disk/by-uuid/999658fe-a8e0-4f12-9b40-f24932a303d6";
      fsType = "btrfs";
      options = [ "noatime" "lazytime" "compress=zstd" "gid=501" ];
    };

  fileSystems."/mnt/games" =
    { device = "/dev/disk/by-uuid/bbc5a71c-af08-4d0a-a84d-509ca06f0356";
      fsType = "btrfs";
      options = [ "noatime" "lazytime" "compress=zstd" "gid=569" ];
    };

  fileSystems."/home/${home-user}/games" = 
    {
      depends = [
        "/mnt/games"
        "/home/${home-user}"
      ];

      device = "/mnt/games";
      options = [ "bind" "gid=501" ];
    };
}