{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting ""
    '';
    shellAbbrs = {
      nd = "nix develop -c fish";
      rm = "trash";
      grep = "rg";
    };
  };
}
