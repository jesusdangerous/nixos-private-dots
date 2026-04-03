# Тут настраивается автомаунт нужных дисков
# Замени значения на свои. Узнать uuid можно через `lsblk -f`

{
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/8311b19e-5fe7-4b4f-8196-9c5f7b9bca8";
      fsType = "ext4";
      options = [ "defaults" "noatime" ];
    };

    "/mnt/storage" = {
      device = "/dev/disk/by-uuid/234dc4ed-ade3-447f-af5a-4d254835cc66";
      fsType = "ext4";
      options = [ "defaults" "noatime" ];
    };

    "/nix" = {
      device = "/dev/disk/by-uuid/8B8C-CABC";
      fsType = "ext4";
      options = [ "defaults" "noatime" ];
    };

    "/mnt/data" = {
      device = "/dev/disk/by-uuid/a3ced3c3-320d-42e9-9cbc-d957c74f7a0";
      fsType = "ext4";
      options = [ "defaults" "noatime" ];
    };
  };
}
