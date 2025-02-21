{ pkgs, ... }:
{
  # Enable Polkit, needed for apps like Solaar
  security.polkit.enable = true;

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
     description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
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
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
          user = "greeter";
        };
      };
    };

    dbus.enable = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
    ];
    config = {
      common.default = [
        "gtk"
        "wlr"
      ];
    };
  };

  programs.xwayland.enable = true;
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  # See https://wiki.nixos.org/wiki/Sway#Inferior_performance_compared_to_other_distributions
  security.pam.loginLimits = [
    {
      domain = "@users";
      item = "rtprio";
      type = "-";
      value = 1;
    }
  ];

  environment = {
    systemPackages = with pkgs; [
      polkit_gnome
      vesktop
    ];

    sessionVariables.NIXOS_OZONE_WL = "1";
    sessionVariables._JAVA_AWT_WM_NONREPARENTING = "1";
  };
}
