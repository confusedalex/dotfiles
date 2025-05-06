{ pkgs, ... }:
{
  home.packages = with pkgs; [
    networkmanagerapplet
    nwg-displays
    udiskie
    shotman
    hyprpaper
  ];
}
