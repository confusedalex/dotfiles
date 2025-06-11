_:
{
  stylix.targets.firefox.enable = false;

  programs.firefox = {
    enable = true;
  };
  home = {
    persistence."/persist/home/alex/" = {
      directories = [
        ".mozilla/firefox"
      ];
    };
  };
}
