{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    inputs.disko.nixosModules.default
    inputs.nixos-hardware.nixosModules.lenovo-thinkpad-t490
    (import ./disko.nix { device = "/dev/nvme0n1"; })
    ./hardware-configuration.nix
    ./impermanence.nix
    ../common/global
    ../common/optional/pipewire.nix
    ../common/users/alex
    ../common/optional/systemd-boot.nix
    ../common/optional/network-manager.nix
    ../common/optional/sway.nix
    ../common/optional/bluetooth.nix
    ../common/optional/thunar.nix
    ../common/optional/steam.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  networking.firewall.enable = false;

  # Disable to stall boot by waiting for network (saves about 5s of boot time)
  systemd.services.NetworkManager-wait-online.enable = false;

  programs.fuse.userAllowOther = true;

  networking.hostName = "proba"; # Define your hostname.

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      intel-vaapi-driver # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
    ];
  };
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  }; # Force intel-media-driver

  system.stateVersion = "24.05"; # Did you read the comment?
}
