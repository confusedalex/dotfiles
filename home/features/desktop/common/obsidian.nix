{ pkgs, ... }:
{
  home.packages = [ pkgs.obsidian ];

  home.persistence."/persist/home/alex/".directories = [
    ".config/obsidian"
  ];
}
