# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../common/global
    ../common/optional/pipewire.nix
    ../common/users/alex
    ../common/optional/systemd-boot.nix
    ../common/optional/network-manager.nix
    ../common/optional/bluetooth.nix
    ../common/optional/steam.nix
  ];

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
    };
    useGlobalPkgs = true;
    useUserPackages = true;
    users = {
      "alex".imports = [
        inputs.nur.hmModules.nur
        ../../home/steamdeck.nix
      ];
    };
    backupFileExtension = "backup";
  };
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "steamdeck"; # Define your hostname.

  nixpkgs.config.allowUnfree = true;

  services.flatpak.enable = true;
  services.xserver.enable = true;
  services.desktopManager.plasma6.enable = true;

  jovian = {
    steam = {
      enable = true;
      autoStart = true;
      desktopSession = "plasma";
      user = "alex";
    };
    decky-loader.enable = true;
    devices.steamdeck = {
      enable = true;
      autoUpdate = true;
    };
  };

  environment.persistence."/persistent" = {
    enable = false;
  };

  # programs.steam.enable = true;
  sops.age.keyFile = lib.mkForce "/home/alex/.config/sops/age/keys.txt";

  system.stateVersion = "23.11"; # Did you read the comment?
}
