{ ... }:
{
  services.nginx.virtualHosts."rss.mytbu.de" = {
    forceSSL = true;
    useACMEHost = "mytbu.de";
    locations."/" = {
      proxyPass = "http://localhost:5008";
      proxyWebsockets = true;
    };
  };
}
