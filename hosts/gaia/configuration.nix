{
  pkgs,
  config,
  lib,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ../common/global
    ../common/optional/docker.nix
    ../common/optional/syncthing.nix
    ../common/server
    ../common/users/alex
    ./backups.nix
    ./hardware-configuration.nix
    ./impermanence.nix
  ];

  networking.firewall.enable = false;

  # 1. enable vaapi on OS-level
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver # previously vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      intel-compute-runtime # OpenCL filter support (hardware tonemapping and subtitle burn-in)
      vpl-gpu-rt # QSV on 11th gen or newer
      intel-media-sdk # QSV up to 11th gen
    ];
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  services.tailscale.useRoutingFeatures = "server";

  programs.fuse.userAllowOther = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "gaia"; # Define your hostname.

  boot.supportedFilesystems = [ "zfs" ];
  networking.hostId = "623a9464";

  boot.kernelParams = [ "ip=dhcp" ];
  boot.initrd = {
    availableKernelModules = [ "r8169" ];
    systemd.users.root.shell = "/bin/cryptsetup-askpass";
    network = {
      enable = true;
      ssh = {
        enable = true;
        port = 8192;
        authorizedKeys = [
          "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC889TcvmQlCkDKZxz6p0VNN4mEFLzvSHUYDHPLg1PxxqncCUPdnuXvTx+ayf3gQmaI+gNCntJ3NMgB0p4/CfqVThMnN6SoqjVj32PxbKCV1JFQW1PcnS/iK4mZ/H2Vtm9uz5prM6bTUuxKCpczgpTpZS0b3VIxdm9J5hY7ou6xW6bAz25EA7mezupFh2QlIyu1FvgOrRaPQZs0ky0uljrdKOkDmtPgQ6Fj3wM2PkUrxuBGWav0SiQ4R9wuJw84lQ9+eB13kewfM+R8wusLY81whUgikDg1v1Fn+Nj1CmCuZg0Pxr73SFRR2nJqLQf56U7G0jCSF/e52OuRIqeusNpbAS8a5bSvs6PnCDV7N39OkAkAMiK4cjRtcZK40zVEYutaDoB/qVNhkeaFUAyvwMmKakE3WKORMUHOOkLqDUrxFeqhHirvg252lUSxDotXzQTx4FpXZa9uyFtwSeuiNl2pDMVN7feXh6D3dFdCHFtQXSvhLdzHmxNrqy747BX41HvNIAmPwBYUT0WVjlxHAmLlb+XUl1ue8vKw9+veicvNnBy49y0W38BWW+mMtOg+p+WeTKKkns8xTxAevRnTsCfJfqZym6NOLbtwr7iCqgd8nqAmKmOn/vYVXMEUCMjsnVYzoXlRiCCCONaDUlLpYnkyFoMysPD/GtzQ2p4w8GEsVw== cardno:19_764_596"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBDCa78D6trTmSyyAwmf2w4uPx6Bhm7m7C3f2as6xZ4O alex@confusedalex.dev"
        ];
        hostKeys = [ "/etc/secrets/initrd/ssh_host_rsa_key" ];
      };
      postCommands = ''
        # Automatically ask for the password on SSH login
        echo 'cryptsetup-askpass || echo "Unlock was successful; exiting SSH session" && exit 1' >> /root/.profile
      '';
    };
  };

  ## ZFS secret
  sops.secrets."zfs_password" = { };

  system.stateVersion = "24.05"; # Did you read the comment?
}
