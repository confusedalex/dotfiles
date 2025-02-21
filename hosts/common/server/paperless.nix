# Auto-generated using compose2nix v0.2.0-pre.
{
  pkgs,
  lib,
  ...
}:
{
  virtualisation.oci-containers.containers."paperless-broker" = {
    image = "docker.io/library/redis:7";
    volumes = [ "/storage/appdata/paperless/redisdata:/data:rw" ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=broker"
      "--network=paperless_default"
    ];
  };
  systemd.services."docker-paperless-broker" = {
    serviceConfig = {
      Restart = lib.mkOverride 500 "always";
      RestartMaxDelaySec = lib.mkOverride 500 "1m";
      RestartSec = lib.mkOverride 500 "100ms";
      RestartSteps = lib.mkOverride 500 9;
    };
    after = [ "docker-network-paperless_default.service" ];
    requires = [ "docker-network-paperless_default.service" ];
    partOf = [ "docker-compose-paperless-root.target" ];
    wantedBy = [ "docker-compose-paperless-root.target" ];
  };
  virtualisation.oci-containers.containers."paperless-db" = {
    image = "docker.io/library/postgres:16";
    environment = {
      POSTGRES_DB = "paperless";
      POSTGRES_PASSWORD = "paperless";
      POSTGRES_USER = "paperless";
    };
    volumes = [ "/storage/appdata/paperless/pgdata:/var/lib/postgresql/data:rw" ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=db"
      "--network=paperless_default"
    ];
  };
  systemd.services."docker-paperless-db" = {
    serviceConfig = {
      Restart = lib.mkOverride 500 "always";
      RestartMaxDelaySec = lib.mkOverride 500 "1m";
      RestartSec = lib.mkOverride 500 "100ms";
      RestartSteps = lib.mkOverride 500 9;
    };
    after = [ "docker-network-paperless_default.service" ];
    requires = [ "docker-network-paperless_default.service" ];
    partOf = [ "docker-compose-paperless-root.target" ];
    wantedBy = [ "docker-compose-paperless-root.target" ];
  };
  virtualisation.oci-containers.containers."paperless-gotenberg" = {
    image = "docker.io/gotenberg/gotenberg:8.7";
    cmd = [
      "gotenberg"
      "--chromium-disable-javascript=true"
      "--chromium-allow-list=file:///tmp/.*"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=gotenberg"
      "--network=paperless_default"
    ];
  };
  systemd.services."docker-paperless-gotenberg" = {
    serviceConfig = {
      Restart = lib.mkOverride 500 "always";
      RestartMaxDelaySec = lib.mkOverride 500 "1m";
      RestartSec = lib.mkOverride 500 "100ms";
      RestartSteps = lib.mkOverride 500 9;
    };
    after = [ "docker-network-paperless_default.service" ];
    requires = [ "docker-network-paperless_default.service" ];
    partOf = [ "docker-compose-paperless-root.target" ];
    wantedBy = [ "docker-compose-paperless-root.target" ];
  };
  virtualisation.oci-containers.containers."paperless-tika" = {
    image = "docker.io/apache/tika:latest";
    log-driver = "journald";
    extraOptions = [
      "--network-alias=tika"
      "--network=paperless_default"
    ];
  };
  systemd.services."docker-paperless-tika" = {
    serviceConfig = {
      Restart = lib.mkOverride 500 "always";
      RestartMaxDelaySec = lib.mkOverride 500 "1m";
      RestartSec = lib.mkOverride 500 "100ms";
      RestartSteps = lib.mkOverride 500 9;
    };
    after = [ "docker-network-paperless_default.service" ];
    requires = [ "docker-network-paperless_default.service" ];
    partOf = [ "docker-compose-paperless-root.target" ];
    wantedBy = [ "docker-compose-paperless-root.target" ];
  };
  virtualisation.oci-containers.containers."paperless-webserver" = {
    image = "ghcr.io/paperless-ngx/paperless-ngx:latest";
    environment = {
      PAPERLESS_URL = "https://documents.mytbu.de";
      PAPERLESS_DBHOST = "db";
      PAPERLESS_OCR_LANGUAGE = "deu";
      PAPERLESS_OCR_LANGUAGES = "eng deu";
      PAPERLESS_REDIS = "redis://broker:6379";
      PAPERLESS_TIKA_ENABLED = "1";
      PAPERLESS_TIKA_ENDPOINT = "http://tika:9998";
      PAPERLESS_TIKA_GOTENBERG_ENDPOINT = "http://gotenberg:3000";
      PAPERLESS_TIME_ZONE = "Europe/Berlin";
      USERMAP_GID = "100";
      USERMAP_UID = "1000";
    };
    volumes = [
      "/storage/appdata/paperless/consume:/usr/src/paperless/consume:rw"
      "/storage/appdata/paperless/data:/usr/src/paperless/data:rw"
      "/storage/appdata/paperless/export:/usr/src/paperless/exdocuments:rw"
      "/storage/appdata/paperless/media:/usr/src/paperless/media:rw"
    ];
    ports = [ "8000:8000/tcp" ];
    dependsOn = [
      "paperless-broker"
      "paperless-db"
      "paperless-gotenberg"
      "paperless-tika"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=webserver"
      "--network=paperless_default"
    ];
  };
  systemd.services."docker-paperless-webserver" = {
    serviceConfig = {
      Restart = lib.mkOverride 500 "always";
      RestartMaxDelaySec = lib.mkOverride 500 "1m";
      RestartSec = lib.mkOverride 500 "100ms";
      RestartSteps = lib.mkOverride 500 9;
    };
    after = [ "docker-network-paperless_default.service" ];
    requires = [ "docker-network-paperless_default.service" ];
    partOf = [ "docker-compose-paperless-root.target" ];
    wantedBy = [ "docker-compose-paperless-root.target" ];
  };

  # Networks
  systemd.services."docker-network-paperless_default" = {
    path = [ pkgs.docker ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStop = "${pkgs.docker}/bin/docker network rm -f paperless_default";
    };
    script = ''
      docker network inspect paperless_default || docker network create paperless_default
    '';
    partOf = [ "docker-compose-paperless-root.target" ];
    wantedBy = [ "docker-compose-paperless-root.target" ];
  };

  # Root service
  # When started, this will automatically create all resources and start
  # the containers. When stopped, this will teardown all resources.
  systemd.targets."docker-compose-paperless-root" = {
    unitConfig = {
      Description = "Root target generated by compose2nix.";
    };
    wantedBy = [ "multi-user.target" ];
  };

  services.nginx.virtualHosts."documents.mytbu.de" = {
    forceSSL = true;
    useACMEHost = "mytbu.de";
    locations."/" = {
      proxyPass = "http://localhost:8000";
      proxyWebsockets = true;
    };
  };
}
