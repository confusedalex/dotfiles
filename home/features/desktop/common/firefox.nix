{ pkgs, ... }:
{
  stylix.targets.firefox.enable = false;

  programs.firefox = {
    enable = true;
    profiles.alex = {
      search = {
        default = "ddg";
        force = true;
      };
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        auto-tab-discard
        bitwarden
        darkreader
        sidebery
        ublock-origin
        vimium-c
      ];
      settings = {
        # Hardware accerlation
        "gfx.webrender.all" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "gfx.webrender.compositor.force-enabled" = true;

        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" = false;

        # Disable "save password" prompt
        "signon.rememberSignons" = false;

        "dom.security.https_only_mode" = true;
        "browser.download.panel.shown" = true;
        "identity.fxaccounts.enabled" = false;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "extensions.pocket.enabled" = false;
      };
    };
  };
  home = {
    persistence."/persist/home/alex" = {
      directories = [
        ".mozilla/firefox"
      ];
      files = [
        # mimeapps.list is a file where default apps are listed. So firefox stays default browser
        ".config/mimeapps.list"
      ];
    };
  };
}
