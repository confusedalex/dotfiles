{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs30-pgtk.pkgs.withPackages (epkgs: [
      (epkgs.treesit-grammars.with-grammars (grammars: [ grammars.tree-sitter-bash ]))
    ]);
  };

  home.persistence."/persist/home/alex/".directories = [ ".config/emacs" ];
}
