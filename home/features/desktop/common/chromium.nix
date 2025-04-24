{ pkgs, ... }:
{
  home.packages = [ pkgs.chromium ];

  home.persistence."/persist/home/alex/".directories = [ ".config/chromium" ];
}
