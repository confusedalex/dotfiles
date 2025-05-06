{ pkgs, ... }:
{
  home.packages = [ pkgs.rclone ];

  home.persistence."/persist/home/alex/".directories = [
    ".config/rclone"
  ];
}
