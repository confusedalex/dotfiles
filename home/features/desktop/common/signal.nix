{ pkgs, ... }:
{
  home.packages = [ pkgs.signal-desktop ];

  home.persistence."/persist/home/alex".directories = [
    ".config/Signal"
  ];
}
