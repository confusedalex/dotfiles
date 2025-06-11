{ pkgs, ... }:
{
  home.packages = [ pkgs.josm ];
  home.persistence."/persist/home/alex/".directories = [
    ".local/share/JOSM"
    ".cache/JOSM"
    ".config/JOSM"
  ];
}
