{
  services.thelounge = {
    enable = true;
    extraConfig = {
      reverseProxy = true;
    };
  };

  services.nginx.virtualHosts."irc.mytbu.de" = {
    forceSSL = true;
    useACMEHost = "mytbu.de";
    locations."/" = {
      proxyPass = "http://localhost:9000";
      proxyWebsockets = true;
    };
  };
  environment.persistence."/persist".directories = [
    "/var/lib/thelounge"
  ];
  systemd.tmpfiles.rules = [
    "d /var/lib/thelounge 700 thelounge thelounge -"
  ];
}
