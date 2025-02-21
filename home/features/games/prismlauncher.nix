{ pkgs, ... }:
{
  home.packages = [ pkgs.prismlauncher ];

  home.persistence."/persist/home/alex/".directories = [ ".local/share/PrismLauncher" ];
}
