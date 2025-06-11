{ config, ... }:
{
  accounts.calendar = {
    basePath = ".local/share/calendars";

    accounts.nextcloud = {
      khal = {
        enable = true;
        type = "discover";
      };

      vdirsyncer = {
        enable = true;
        collections = [
          "from a"
          "from b"
        ];
        metadata = [
          "color"
          "displayname"
        ];
        conflictResolution = "remote wins";
      };

      local = {
        type = "filesystem";
        fileExt = ".ics";
      };

      remote = {
        type = "caldav";
        url = "https://cloud.mytbu.de/remote.php/dav";
        userName = "alex";
        passwordCommand = [
          "cat"
          "${config.sops.secrets.local-password.path}"
        ];
      };
    };
  };

  programs.vdirsyncer.enable = true;
  programs.khal = {
    enable = true;

    locale = {
      timeformat = "%H:%M";
      dateformat = "%d/%m/%Y";
      datetimeformat = "%d/%m/%Y %H:%M";
    };
  };

  home.persistence."/persist/home/alex/".directories = [
    ".local/share/calendars"
    ".local/share/vdirsyncer/status"
  ];

  sops.secrets.local-password = {
    sopsFile = ../secrets.yaml;
  };
}
