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
    # copilot
    copilot-language-server
	
    # email
    mu

    # go
    gopls
    go
    go-tools

    # nix
    nixfmt-rfc-style
    nixd

    # python
    ruff
    pyright

    # typescript
    typescript-language-server

    # vuejs
    vue-language-server
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
