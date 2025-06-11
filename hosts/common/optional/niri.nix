{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    wl-clipboard
    xwayland-satellite
    nautilus
  ];

  environment = {
    sessionVariables.NIXOS_OZONE_WL = "1";
    sessionVariables._JAVA_AWT_WM_NONREPARENTING = "1";
  };

  # Enable the gnome-keyring secrets vault.
  # Will be exposed through DBus to programs willing to store secrets.
  services.dbus.enable = true;

  # enable niri
  programs.niri.enable = true;

  security.pam.services.swaylock = { };
}
