{
  programs.zellij = {
    enable = true;
    enableFishIntegration = false;
    settings = {
      default_layout = "compact";
    };
  };

  home.shellAliases = {
    ss = "zellij -l welcome";
  };

  home.persistence."/persist/home/alex".directories = [ ".cache/zellij" ];
}
