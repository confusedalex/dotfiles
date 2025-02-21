{
  pkgs,
  config,
  ...
}:
{
  home.packages = with pkgs; [
    w3m
    dante
    xdg-utils
    libnotify
  ];
  programs = {
    mbsync.enable = true;
    aerc = {
      enable = true;
      extraConfig = {
        general = {
          unsafe-accounts-conf = true;
          default-save-path = "~/Downloads/";
        };
        ui = {
          this-day-time-format = ''"           15:04"'';
          timestamp-format = "2006-01-02 15:04";
          sort = "date";
          dirlist-right = "{{if .Unread}}{{humanReadable .Unread}}/{{end}}{{if .Exists}}{{humanReadable .Exists}}{{end}}";
          dirlist-tree = true;
          threading-enabled = true;
          icon-encrypted = "󰯄";
          icon-signed = "";
          icon-unknown = "";
          icon-attachment = "";
          icon-new = "";
          icon-old = "";
          icon-replied = "";
          icon-marked = "󰄳";
          icon-flagged = "";
          icon-deleted = "";
        };
        filters = {
          "text/plain" = "colorize";
          "text/html" = "html";
          "text/calendar" = "calendar";
          "message/delivery-status" = "colorize";
          "message/rfc822" = "colorize";
          "image/*" = "${pkgs.catimg}/bin/catimg -";
        };
        hooks = {
          aerc-startup = "mbsync -a";
        };
      };
    };
    msmtp.enable = true;
    notmuch = {
      enable = true;
      hooks.preNew = "mbsync --all";
    };
  };

  accounts.email = {
    maildirBasePath = "Mail";
    accounts = {
      personal = {
        primary = true;
        address = "alex@confusedalex.dev";
        userName = "alex@confusedalex.dev";
        realName = "confusedalex";
        passwordCommand = "${pkgs.coreutils}/bin/cat ${config.sops.secrets.purelymail-password.path}";
        imap.host = "imap.purelymail.com";
        smtp.host = "smtp.purelymail.com";
        mbsync = {
          enable = true;
          create = "both";
          expunge = "both";
        };
        msmtp.enable = true;
        notmuch.enable = true;
        aerc = {
          enable = true;
          extraAccounts = {
            check-mail-cmd = "mbsync -a";
            aliases = [
              ''"confusedalex" <*@confusedalex.dev>''
              ''"Alexander Loll" <*@confusedserver.de>''
            ];
          };
        };
        imapnotify = {
          enable = true;
          boxes = [ "Inbox" ];
          onNotify = "${pkgs.isync}/bin/mbsync --all && ${pkgs.libnotify}/bin/notify-send 'New mail arrived'";
        };
      };
      uni-hagen = {
        aerc.enable = true;
        address = "alexander.loll@studium.fernuni-hagen.de";
        realName = "Alexander Loll";
        imap.host = "studium.fernuni-hagen.de";
        smtp.host = "studium.fernuni-hagen.de";

        mbsync = {
          enable = true;
          create = "both";
          expunge = "both";
        };
        msmtp.enable = true;

        userName = "alexander.loll@studium.fernuni-hagen.de";
        passwordCommand = "${pkgs.coreutils}/bin/cat ${config.sops.secrets.fernuni-hagen-email-password.path}";
      };
      work = {
        aerc.enable = true;
        address = "a.loll@qvest-digital.com";
        realName = "Alexander Loll";

        mbsync = {
          enable = true;
          create = "both";
          expunge = "both";
        };
        msmtp.enable = true;
        flavor = "gmail.com";

        userName = "a.loll@qvest-digital.com";
        passwordCommand = "${pkgs.coreutils}/bin/cat ${config.sops.secrets.qvest-gmail.path}";
      };
    };
  };

  services = {
    imapnotify.enable = true;
    mbsync.enable = true;
  };

  home.persistence."/persist/home/alex".directories = [
    "Mail"
    ".config/aerc"
  ];

  sops.secrets = {
    purelymail-password = { };
    qvest-gmail = { };
    fernuni-hagen-email-password = { };
  };
}
