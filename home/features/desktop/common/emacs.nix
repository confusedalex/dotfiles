{ pkgs, ... }:
{
  home.packages = with pkgs; [
    emacs-pgtk
  ];

  home.persistence."/persist/home/alex/".directories = [
    ".config/emacs"
    ".config/doom"
  ];
}
