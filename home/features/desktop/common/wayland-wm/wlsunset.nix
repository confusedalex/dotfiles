{ pkgs, ... }:
{
  home.packages = [ pkgs.wlsunset ];

  services.wlsunset = {
    enable = true;
    latitude = "6.952778";
    longitude = "50.936389";
  };
}
