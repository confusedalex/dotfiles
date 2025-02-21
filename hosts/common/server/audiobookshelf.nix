{
  services.audiobookshelf = {
    enable = true;
    port = 5465;
  };

  services.nginx.virtualHosts."audiobooks.mytbu.de" = {
    forceSSL = true;
    useACMEHost = "mytbu.de";
    locations."/" = {
      proxyPass = "http://localhost:5465";
      proxyWebsockets = true;
    };
  };

  environment.persistence."/persist".directories = [ "/var/lib/audiobookshelf" ];
  systemd.tmpfiles.rules = [ "d /var/lib/audiobookshelf 700 audiobookshelf audiobookshelf -" ];
}
