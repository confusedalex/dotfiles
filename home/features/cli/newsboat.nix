{ config, ... }:
{
  programs.newsboat = {
    enable = true;
    extraConfig = ''
      urls-source "freshrss"
      freshrss-url "https://rss.mytbu.de/api/greader.php"
      freshrss-login "alex"
      freshrss-passwordfile ${config.sops.secrets.local-password.path}
    '';
  };

  home.file.".config/newsboat/urls" = {
    text = ''
      "query:Unread Articles:unread = \"yes\""
      "query:No Youtube:unread =\"yes\" and tags !# \"Youtube\"
    '';
  };

  sops.secrets.local-password = {
    sopsFile = ../secrets.yaml;
  };
}
