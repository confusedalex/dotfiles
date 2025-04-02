{ pkgs, ... }:
{
  stylix.targets.emacs.enable = false;

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    extraPackages = epkgs: [
      epkgs.treesit-grammars.with-all-grammars
      epkgs.mu4e
    ];
  };

  home.packages = with pkgs; [
    # LSPs
    python311Packages.python-lsp-server
    # email
    mu
    nixd
  ];

  home.persistence."/persist/home/alex/".directories = [
    ".emacs.d"

    # mu
    ".cache/mu"

    # Doom
    # ".config/emacs"
    # ".config/doom"
  ];
}
