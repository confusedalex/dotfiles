{
  programs = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    fish.shellAliases = {
      setup-direnv = ''echo "use flake" >> .envrc && direnv allow'';
    };
  };
}
