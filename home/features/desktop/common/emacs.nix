{ pkgs, ... }:
{
  stylix.targets.emacs.enable = false;

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    extraPackages = epkgs: [ epkgs.treesit-grammars.with-all-grammars ];
  };

  home.packages = with pkgs; [
    # LSPs
    python311Packages.python-lsp-server
    nixd
  ];

  home.persistence."/persist/home/alex/".directories = [
    ".emacs.d"

    # Doom
    # ".config/emacs"
    # ".config/doom"
  ];
}
