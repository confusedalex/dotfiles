{ pkgs, ... }:
{
  home.packages = with pkgs; [
    libreoffice
    pandoc
    texlive.combined.scheme-full
    texstudio
  ];
}
