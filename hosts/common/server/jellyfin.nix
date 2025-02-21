{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
  ];

  services.jellyfin = {
    enable = true;
    dataDir = "/storage/appdata/jellyfin";
  };

  services.nginx.virtualHosts."media.mytbu.de" = {
    forceSSL = true;
    useACMEHost = "mytbu.de";
    locations."/" = {
      proxyPass = "http://localhost:8096";
      proxyWebsockets = true;
    };
  };
}
