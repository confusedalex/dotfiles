{ pkgs, ... }:
{
  home.packages = [ pkgs.vesktop ];
  home.persistence."/persist/home/alex/".directories = [ ".config/vesktop" ];
}
