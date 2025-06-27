{ pkgs, ... }:
{

  home.packages = [ pkgs.thunderbird ];

  home.persistence."/persist/home/alex/".directories = [
    ".mozilla/thunderbird"
    ".thunderbird"
    ".cache/thunderbird"
  ];
}
