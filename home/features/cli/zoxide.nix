{
  programs.zoxide.enable = true;
  home.persistence."/persist/home/alex".directories = [ ".local/share/zoxide" ];

  home.shellAliases = {
    cd = "z";
    cdi = "zi";
  };
  
  programs.fish.shellAbbrs = {
    cd = "z";
  };
}
