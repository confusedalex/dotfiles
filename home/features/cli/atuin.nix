{
  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };
  home.persistence."/persist/home/alex/".directories = [ ".local/share/atuin" ];
}
