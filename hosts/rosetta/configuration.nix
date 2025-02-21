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
    ../common/optional/keyd.nix
    ../common/optional/network-manager.nix
    ../common/optional/pipewire.nix
    ../common/optional/printing.nix
    ../common/optional/steam.nix
    ../common/optional/sway.nix
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

  hardware.graphics = {
    # hardware.opengl in 24.05 and older
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # For Broadwell (2014) or newer processors. LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver # For older processors. LIBVA_DRIVER_NAME=i965
    ];
  };
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };

  fonts.packages = [ pkgs.atkinson-hyperlegible ];

  services.hardware.bolt.enable = true;
  services.udisks2.enable = true;

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    kernelParams = [
      "resume_offset=533760"
    ];
    resumeDevice = "/dev/disk/by-label/nixos";
  };

  system.stateVersion = "24.05"; # Did you read the comment?
}
