{ pkgs, ... }:
{
  stylix.targets.emacs.enable = false;

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    extraPackages = epkgs: [
      epkgs.treesit-grammars.with-all-grammars
      epkgs.mu4e
      epkgs.vterm
    ];
  };

  home.packages = with pkgs; [
    # email
    mu
	
    # Copilot
    copilot-language-server

    # Go
    gopls
    go
    go-tools

    # Nix
    nixfmt-rfc-style
    nixd

    # Python
    ruff
    pyright
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
