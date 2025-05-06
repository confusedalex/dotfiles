{ pkgs, ... }:
{
  programs.hyprland = {
    enable = true;
    withUWSM = true; # recommended for most users
    xwayland.enable = true; # Xwayland can be disabled.
  };

  programs.hyprlock.enable = true;

  environment = {
    systemPackages = with pkgs; [
      # polkit_gnome
      vesktop
    ];

    sessionVariables.NIXOS_OZONE_WL = "1";
    sessionVariables._JAVA_AWT_WM_NONREPARENTING = "1";
  };

  services = {
    # Enable the gnome-keyring secrets vault.
    # Will be exposed through DBus to programs willing to store secrets.
    gnome.gnome-keyring.enable = true;

    dbus.packages = [ pkgs.gcr ];

    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
          user = "greeter";
        };
      };
    };

    dbus.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-hyprland ];
  };
}
