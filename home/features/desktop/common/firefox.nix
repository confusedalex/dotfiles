{ pkgs, ... }:
{
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
      userChrome = ''
        /* IMPORTANT */
        /*
        Get window_control_placeholder_support.css
        Window controls will be all wrong without it
        */

        :root[tabsintitlebar]{ --uc-toolbar-height: 40px; }
        :root[tabsintitlebar][uidensity="compact"]{ --uc-toolbar-height: 32px }
        #titlebar{
          will-change: unset !important;
          transition: none !important;
          opacity: 1 !important;
        }
        #TabsToolbar{ visibility: collapse !important }
        :root[sizemode="fullscreen"] #titlebar{ position: relative }

        :root[sizemode="fullscreen"] #TabsToolbar > .titlebar-buttonbox-container{
          visibility: visible !important;
          z-index: 2;
        }

        :root:not([inFullscreen]) #nav-bar{
          margin-top: calc(0px - var(--uc-toolbar-height,0px));
        }

        :root[tabsintitlebar] #toolbar-menubar[autohide="true"]{
          min-height: unset !important;
          height: var(--uc-toolbar-height,0px) !important;
          position: relative;
        }

        #toolbar-menubar[autohide="false"]{
          margin-bottom: var(--uc-toolbar-height,0px)
        }

        :root[tabsintitlebar] #toolbar-menubar[autohide="true"] #main-menubar{
          flex-grow: 1;
          align-items: stretch;
          background-attachment: scroll, fixed, fixed;
          background-position: 0 0, var(--lwt-background-alignment), right top;
          background-repeat: repeat-x, var(--lwt-background-tiling), no-repeat;
          background-size: auto 100%, var(--lwt-background-size, auto auto), auto auto;
          padding-right: 20px;
        }
        :root[tabsintitlebar] #toolbar-menubar[autohide="true"]:not([inactive]) #main-menubar{
          background-color: var(--lwt-accent-color);
          background-image: linear-gradient(var(--toolbar-bgcolor,--toolbar-non-lwt-bgcolor),var(--toolbar-bgcolor,--toolbar-non-lwt-bgcolor)), var(--lwt-additional-images,none), var(--lwt-header-image, none);
          mask-image: linear-gradient(to left, transparent, black 20px);
        }

        #toolbar-menubar:not([inactive]){ z-index: 2 }
        #toolbar-menubar[autohide="true"][inactive] > #menubar-items {
          opacity: 0;
          pointer-events: none;
          margin-left: var(--uc-window-drag-space-pre,0px)
        }
      '';
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
    sessionVariables.BROWSER = "firefox";
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = [ "firefox.desktop" ];
    "text/xml" = [ "firefox.desktop" ];
    "x-scheme-handler/http" = [ "firefox.desktop" ];
    "x-scheme-handler/https" = [ "firefox.desktop" ];
  };
}
