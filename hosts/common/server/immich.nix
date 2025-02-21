{
  services.nginx.virtualHosts."photos.mytbu.de" = {
    forceSSL = true;
    useACMEHost = "mytbu.de";
    locations."/" = {
      proxyPass = "http://localhost:2283";
      proxyWebsockets = true;
    };
  };
}
