{ ... }:
{
  services.syncthing.enable = true;
  home.persistence."/persist/home/alex".directories = [ ".local/state/syncthing" ];
}
