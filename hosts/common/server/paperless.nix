{ ... }:
{
  services.nginx.virtualHosts."documents.mytbu.de" = {
    forceSSL = true;
    useACMEHost = "mytbu.de";
    locations."/" = {
      proxyPass = "http://localhost:8000";
      proxyWebsockets = true;
    };
  };
}
