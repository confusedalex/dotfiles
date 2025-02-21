{ pkgs, ... }:
{
  virtualisation = {
    libvirtd = {
      enable = true;
      qemuOvmf = true;
    };
  };

  environment.systemPackages = with pkgs; [
    # For virt-install
    virt-manager

    # For lsusb
    usbutils
  ];
}
