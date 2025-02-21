{
  programs.fish = {
    enable = true;

    shellAbbrs = {
      nd = "nix develop -c fish";
      git-setwork = ''
        git config user.name "Alexander Loll" && git config user.email a.loll@qvest-digital.com && git config gpg.format ssh && git config user.signingkey /home/alex/.ssh/work.pub
      '';
      rm = "trash";
      grep = "rg";
    };
  };
}
