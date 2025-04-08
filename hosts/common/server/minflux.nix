{ ... }:
{
  programs.miniflux = {
    enable = true;
    config = {
      BASE_URL = "https://rss.mytbu.de";
      LISTEN_ADDR = "localhost:5008";
    };
  };

  services.nginx.virtualHosts."rss.mytbu.de" = {
    forceSSL = true;
    useACMEHost = "mytbu.de";
    locations."/" = {
      proxyPass = "http://localhost:5008";
      proxyWebsockets = true;
    };
  };
}
