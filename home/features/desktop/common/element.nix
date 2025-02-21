{ pkgs, ... }:
{
  home.packages = [ pkgs.element-desktop ];

  home.persistence."/persist/home/alex/".directories = [ ".config/Element" ];
}
