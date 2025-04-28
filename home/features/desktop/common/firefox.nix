_:
{
  stylix.targets.firefox.enable = false;

  programs.firefox = {
    enable = true;
  };
  home = {
    persistence."/persist/home/alex" = {
      directories = [
        ".mozilla/firefox"
      ];
      files = [
        # mimeapps.list is a file where default apps are listed. So firefox stays default browser
        ".config/mimeapps.list"
      ];
    };
  };
}
