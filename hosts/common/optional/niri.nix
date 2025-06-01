{
  pkgs,
  ...
}:
{
  environment.systemPackages = with pkgs; [
    wl-clipboard
  ];

  environment = {
    sessionVariables.NIXOS_OZONE_WL = "1";
    sessionVariables._JAVA_AWT_WM_NONREPARENTING = "1";
  };

  # Enable the gnome-keyring secrets vault.
  # Will be exposed through DBus to programs willing to store secrets.
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;
  security.pam.services.greetd.enableGnomeKeyring = true;

  # enable niri
  programs.niri = {
    enable = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd niri --session";
        user = "greeter";
      };
    };
  };

  security.pam.services.swaylock = { };
}
