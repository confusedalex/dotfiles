{
  services.adguardhome = {
    enable = true;
    settings = {
      dns = {
        upstream_dns = [
          "tls://dns.quad9.net"
          "https://dns.quad9.net/dns-query"
          "tls://doh.mullvad.net"
          "https://doh.mullvad.net/dns-query"
          "tls://dns.digitale-gesellschaft.ch"
          "tls://1dot1dot1dot1.cloudflare-dns.com"
          "https://dns.cloudflare.com/dns-query"
        ];
      };
      filters = [
        {
          name = "OISD (Big)";
          url = "https://big.oisd.nl";
          enabled = true;
        }
      ];
    };
  };

  environment.persistence."/persist".directories = [
    {
      directory = "/var/lib/private";
      mode = "0700";
    }
  ];

  services.nginx.virtualHosts."dns.mytbu.de" = {
    forceSSL = true;
    useACMEHost = "mytbu.de";
    locations."/" = {
      proxyPass = "http://localhost:3000";
      proxyWebsockets = true;
    };
  };
}
