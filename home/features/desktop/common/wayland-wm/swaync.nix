{
  stylix.targets.swaync.enable = false;

  services.swaync = {
    enable = true;
    settings = {
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      "control-center-layer" = "top";
      "layer-shell" = true;
      cssPriority = "application";
      "control-center-margin-top" = 0;
      "control-center-margin-bottom" = 0;
      "control-center-margin-right" = 7;
      "control-center-margin-left" = 0;
      "notification-2fa-action" = true;
      "notification-inline-replies" = false;
      "notification-icon-size" = 24;
      "notification-body-image-height" = 100;
      "notification-body-image-width" = 200;
      timeout = 6;
      "timeout-low" = 3;
      "timeout-critical" = 0;
      "fit-to-screen" = false;
      "control-center-width" = 400;
      "control-center-height" = 1027;
      "notification-window-width" = 400;
      "keyboard-shortcuts" = true;
      "image-visibility" = "when-available";
      "transition-time" = 200;
      "hide-on-clear" = false;
      "hide-on-action" = true;
      "script-fail-notify" = true;
    };
    style = ''
      @define-color dark0_hard #1d2021;
      /*{{{*/
      @define-color dark0 #282828;
      @define-color dark0_soft #32302f;
      @define-color dark1 #3c3836;
      @define-color dark2 #504945;
      @define-color dark3 #665c54;
      @define-color dark4 #7c6f64;
      @define-color dark4_256 #7c6f64;
      @define-color gray_245 #928374;
      @define-color gray_244 #928374;
      @define-color light0_hard #f9f5d7;
      @define-color light0 #fbf1c7;
      @define-color light0_soft #f2e5bc;
      @define-color light1 #ebdbb2;
      @define-color light2 #d5c4a1;
      @define-color light3 #bdae93;
      @define-color light4 #a89984;
      @define-color light4_256 #a89984;
      @define-color bright_red #fb4934;
      @define-color bright_green #b8bb26;
      @define-color bright_yellow #fabd2f;
      @define-color bright_blue #83a598;
      @define-color bright_purple #d3869b;
      @define-color bright_aqua #8ec07c;
      @define-color bright_orange #fe8019;
      @define-color neutral_red #cc241d;
      @define-color neutral_green #98971a;
      @define-color neutral_yellow #d79921;
      @define-color neutral_blue #458588;
      @define-color neutral_purple #b16286;
      @define-color neutral_aqua #689d6a;
      @define-color neutral_orange #d65d0e;
      @define-color faded_red #9d0006;
      @define-color faded_green #79740e;
      @define-color faded_yellow #b57614;
      @define-color faded_blue #076678;
      @define-color faded_purple #8f3f71;
      @define-color faded_aqua #427b58;
      @define-color faded_orange #af3a03;
      /*}}}*/

      * {
        font-family: FiraCode;
      }

      .widget-buttons-grid .text-button,
      .widget-mpris-player,
      .control-center,
      .control-center-clear-all,
      .notification {
        border: 5px solid black;
        border-radius: 10px;
        box-shadow: 5px 5px black;
      }

      .control-center {
        margin-top: 10px;
        margin-bottom: 10px;
        margin-right: 10px;
        background-color: @neutral_yellow;
      }

      .widget-dnd,
      .widget-title {
        color: black;
        font-size: 16px;
        font-weight: bold;
      }

      .widget-dnd>switch {
        border-radius: 5px;
        background: #665c54;
        border: 3px solid black;
      }

      .widget-dnd>switch:checked {
        background: @neutral_red;
      }

      .widget-dnd>switch slider {
        background: black;
        border-radius: 3px
      }

      .widget-mpris-player {
        background-color: @neutral_blue;
      }

      .widget-mpris-album-art {
        box-shadow: none;
      }

      .widget-mpris>.horizontal>.image-button {
        margin-top: 60px;
        margin-bottom: 60px;
        border-radius: 15px;
        border-top-left-radius: 0;
        border-bottom-left-radius: 0;
        border: 5px solid black;
        border-left: none;
        background-color: @faded_blue;
        box-shadow: 0px 5px black;
      }

      .widget-mpris>.horizontal>.image-button:nth-child(3) {
        border-radius: 15px;
        border-top-right-radius: 0;
        border-bottom-right-radius: 0;
        border: 5px solid black;
        border-right: none;
      }

      .widget-buttons-grid {
        background: none;
        padding: 0px 10px;
        margin-top: 1px;
      }

      /* move buttons grid 20px up if there's the mpris player above it */
      .widget-mpris+.widget-buttons-grid {
        margin-top: -20px;
      }

      .widget-buttons-grid .text-button {
        background-color: @neutral_red;
        font-size: 20px;
      }

      .widget-buttons-grid .text-button:hover {
        background-color: @bright_red;
      }

      .control-center-clear-all {
        background-color: @faded_purple;
      }

      .control-center-clear-all:hover {
        background-color: @neutral_purple;
      }

      /* The "No Notifications" text and image */
      .control-center-list-placeholder {
        color: black;
      }

      /* Notification popup styling follows. */

      .notification {
        border: 5px solid black;
        box-shadow: 5px 5px black;
        background-color: @neutral_yellow;
      }

      .control-center .notification {
        background-color: @faded_orange;
      }

      .body,
      .summary,
      .notification-action {
        color: black;
      }

      .control-center .body,
      .control-center .summary,
      .control-center .notification-action {
        color: white;
      }

      .notification-action {
        border-color: black;
      }

      /* .control-center .notification-action { */
      /*   border-color: white; */
      /* } */

      .notification-action:hover {
        border-bottom-left-radius: 6px;
        border-bottom-right-radius: 6px;
        background-color: @bright_yellow;
      }

      .notification-default-action:hover {
        border-top-left-radius: 6px;
        border-top-right-radius: 6px;
        background-color: @bright_yellow;
      }


      .control-center .notification-action:hover {
        background-color: @neutral_orange;
      }

      .control-center .notification-default-action:hover {
        background-color: @neutral_orange;
      }

      .close-button {
        border: 4px solid black;
        border-radius: 10px;
        margin: 6px;
        padding: 0px;
        background-color: @neutral_red;
        color: black;
      }

      .close-button:hover {
        background-color: @bright_red;
      }

      .time {
        margin-right: 40px;
      }

      .notification-group-header,
      .notification-group-icon {
        color: black;
      }

      .notification-group-close-all-button,
      .notification-group-collapse-button {
        border: 4px solid black;
        border-radius: 10px;
        padding: 2px;
        margin: 3px;
        box-shadow: 3px 3px black;
        color: black;
      }

      .notification-group-close-all-button {
        background-color: @neutral_red;
      }

      .notification-group-collapse-button {
        background-color: @neutral_blue;
      }

    '';
  };
}
