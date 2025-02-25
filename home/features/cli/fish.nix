{
  programs.fish = {
    enable = true;

    shellAbbrs = {
      nd = "nix develop -c fish";
      rm = "trash";
      grep = "rg";
    };
  };
}
