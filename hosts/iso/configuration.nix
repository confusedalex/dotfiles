{
  inputs,
  pkgs,
  modulesPath,
  ...
}:
{
  imports = [
    # "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
    ./impermanence.nix
    ../common/global
    ../common/optional/pipewire.nix
    ../common/users/alex
    ../common/optional/systemd-boot.nix
    ../common/optional/hyprland.nix
    ../common/optional/bluetooth.nix
    ../common/optional/thunar.nix
  ];

  environment.systemPackages = with pkgs; [
    cfdisk
  ];

  programs.fuse.userAllowOther = true;
  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
    };
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      "alex".imports = [
        inputs.nur.hmModules.nur
        ../../home/iso.nix
      ];
    };
  };

  nixpkgs.hostPlatform = "x86_64-linux";
}
