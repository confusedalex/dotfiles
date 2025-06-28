{
  pkgs,
  inputs,
  config,
  ...
}:
let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  users.users.alex = {
    isNormalUser = true;
    hashedPasswordFile = config.sops.secrets.alex_password.path;
    shell = pkgs.fish;
    packages = [ pkgs.home-manager ];

    extraGroups = ifTheyExist [
	  "adbusers"
      "audio"
      "deluge"
      "docker"
      "git"
      "i2c"
      "kvm"
      "libvirtd"
      "lxd"
      "minecraft"
      "mysql"
      "network"
      "networkmanager"
      "nextcloud"
      "podman"
      "postgres"
      "video"
      "wheel"
      "wireshark"
    ];
  };

  sops.secrets.alex_password = {
    sopsFile = ../../secrets.yaml;
    neededForUsers = true;
  };

  home-manager.users.alex = import ../../../../home/${config.networking.hostName}.nix;
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
  };

  security.pam.services.swaylock = { };
  security.pam.services.hyprlock = { };
}
