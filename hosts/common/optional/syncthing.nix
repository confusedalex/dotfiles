{
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    group = "users";
    user = "alex";
    configDir = "/storage/appdata/syncthing/config";
    dataDir = "/storage/appdata/syncthing/data";
    guiAddress = "0.0.0.0:8384";
  };

  systemd.services.syncthing.environment.STNODEFAULTFOLDER = "true"; # Don't create default ~/Sync folder
}
