{
  pkgs,
  config,
  inputs,
  ...
}:
{
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud31;
    autoUpdateApps.enable = true;
    config = {
      adminuser = "alex";
      adminpassFile = config.sops.secrets."local_password".path;
      dbtype = "pgsql";
    };

    caching.redis = true;
    configureRedis = true;
    database.createLocally = true;
    extraAppsEnable = true;
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps) contacts calendar notes integration_paperless tasks;
    };

    hostName = "cloud.mytbu.de";
    settings = {
      trusted_domains = [ "cloud.mytbu.de" ];
      overwriteprotocol = "https";
    };
  };

  environment.persistence."/persist".directories = [
    "/var/lib/nextcloud"
    "/var/lib/postgresql"
  ];
  systemd.tmpfiles.rules = [
    "d /var/lib/nextcloud 700 nextcloud nextcloud -"
    "d /var/lib/postgresql 700 postgres postgres  -"
  ];

  # services.nginx.virtualHosts."nextcloud".listen = [{ addr = "127.0.0.1"; port = 8009; }];
  services.nginx.virtualHosts."cloud.mytbu.de" = {
    forceSSL = true;
    # acmeRoot = null;
    useACMEHost = "mytbu.de";
    # acmeRoot = "mytbu.de";
  };

  services.nginx.clientMaxBodySize = "50000M";

  users.users.nginx.extraGroups = [ "acme" ];
  users.users.alex.extraGroups = [ "nextcloud" ];

  sops.secrets.local_password = {
    sopsFile = ../secrets.yaml;
    neededForUsers = true;
    mode = "444";
  };
}
