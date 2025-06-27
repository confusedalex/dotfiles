{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    inputs.disko.nixosModules.default
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t14s
    inputs.nixos-hardware.nixosModules.common-cpu-intel
    ./disks.nix
    ./hardware-configuration.nix
    ./impermanence.nix
    ../common/global
    ../common/optional/bluetooth.nix
    ../common/optional/displaylink.nix
    ../common/optional/docker.nix
    ../common/optional/keyd.nix
    ../common/optional/network-manager.nix
    ../common/optional/pipewire.nix
    ../common/optional/printing.nix
    ../common/optional/steam.nix
    ../common/optional/niri.nix
    # ../common/optional/sway.nix
    ../common/optional/systemd-boot.nix
    ../common/users/alex
  ];
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  networking.firewall.enable = true;

  # Disable to stall boot by waiting for network (saves about 5s of boot time)
  systemd.services.NetworkManager-wait-online.enable = false;

  networking.hostName = "rosetta"; # Define your hostname.

  # Enable propritary drivers :/
  hardware.enableAllFirmware = true;
  hardware.cpu.intel.updateMicrocode = true;

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      vpl-gpu-rt
      intel-compute-runtime
    ];
  };

  services.hardware.bolt.enable = true;
  services.udisks2.enable = true;
  services.fwupd.enable = true;

  programs.adb.enable = true;

  nixpkgs.config.android_sdk.accept_license = true;

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    kernelParams = [
      "resume_offset=533760"
    ];
    resumeDevice = "/dev/disk/by-label/nixos";
  };

  # needed for vintage story to run
  nixpkgs.config.permittedInsecurePackages = [
    "dotnet-runtime-7.0.20"
  ];

  system.stateVersion = "24.05"; # Did you read the comment?
}
