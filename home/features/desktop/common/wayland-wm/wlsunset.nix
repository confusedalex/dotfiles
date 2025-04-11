{ pkgs, ... }:
{
  home.packages = [ pkgs.wlsunset ];

  services.wlsunset = {
    enable = true;
    latitude = "50.735";
    longitude = "5.104";
  };
}
