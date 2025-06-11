{ pkgs, ... }:
{
  home.packages = [ pkgs.vintagestory ];

  home.persistence."/persist/home/alex/".directories = [
    ".config/VintagestoryData"
  ];
}
