{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs30-pgtk;
  };

  home.persistence."/persist/home/alex/".directories = [
    ".config/emacs"
    ".config/doom"
  ];
}
