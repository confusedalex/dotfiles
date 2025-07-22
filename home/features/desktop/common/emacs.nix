{ pkgs, ... }:
{
  stylix.targets.emacs.enable = false;

  home.sessionVariables = {
    LSP_USE_PLISTS = "true";
  };

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

    gnuplot

    mermaid-cli

    # typescript
    typescript-language-server

    # vuejs
    vue-language-server

    # misc
    nodePackages.prettier
    semgrep
    jdk
    graphviz
  ];

  home.persistence."/persist/home/alex/" = {
    files = [
      ".authinfo"
    ];
    directories = [
      ".emacs.d"
      ".cache/mu"
    ];
  };
}
