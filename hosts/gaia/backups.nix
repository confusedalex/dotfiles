{ config, ... }:
{
  services.restic.backups = {
    daily = {
      repository = config.sops.secrets."restic_repository_appdata";
      passwordFile = config.sops.secrets."backup_gaia".path;
      paths = [ "/storage/appdata" ];
    };
  };

  sops.secrets = {
    backup_gaia = { };
    restic_repository_appdata = { };
  };

  systemd.services.immich-database-dump = {
    # Because services.restic.backups autmatically creates a service, we can let the service depend on this one
    wantedBy = [ "restic-backups-daily.service" ];
    script = ''
      docker exec -t immich_postgres pg_dumpall --clean --if-exists --username=postgres > /storage/appdata/immich/immich-database.sql
    '';
  };
}
