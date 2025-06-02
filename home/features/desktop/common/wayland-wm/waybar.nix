{
  pkgs,
  ...
}:
{
  home.packages = [ pkgs.brightnessctl ];
  stylix.targets.waybar.enable = false;

  programs.waybar = {
    enable = true;
    settings = [
      {
        layer = "top";
        position = "top";

        "modules-left" = [
          "custom/logo"
          "niri/workspaces"
        ];
        "modules-center" = [ "clock" ];
        "modules-right" = [
          "tray"
          "backlight"

          "pulseaudio"
          "network"
          "battery"
        ];
        "niri/workspaces" = {
          "disable-scroll" = true;
          "on-click" = "activate";
          "format" = "{icon}";
          "all-outputs" = false;
          "format-icons" = {
            "dev" = "";
            "browser" = "";
            "emacs" = "";
            "signal" = "󰭹";

            "default" = "";
          };
        };
        "custom/logo" = {
          format = "󱄅";
          tooltip = false;
        };
        tray = {
          "icon-size" = 16;
          spacing = 10;
        };
        clock = {
          interval = 1;
          format = "{:%H:%M %A, %d-%m-%Y}";
          "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          tooltip = true;
        };
        network = {
          interval = 1;
          "format-wifi" = "󰖩 {essid}";
          "format-ethernet" = "󰈀 {ipaddr}";
          "format-linked" = "󰈀 {essid} (No IP)";
          "format-disconnected" = "󰌙 Disconnected";
          "format-alt" = "{bandwidthDownBits}";
          "tooltip-format" = "{ifname} ({ipaddr})";
          "on-click-right" = "exec nm-connection-editor";
        };
        pulseaudio = {
          "scroll-step" = 1;
          format = "{icon} {volume}%";
          "format-muted" = "󰝟 Muted";
          "format-icons" = {
            headphone = "󰋋";
            headset = "󰋎";
            default = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
          };
          states = {
            warning = 85;
          };
          "on-click" = "pactl set-sink-mute @DEFAULT_SINK@ toggle";
          "on-scroll-up" = "pactl set-sink-volume @DEFAULT_SINK@ +1%";
          "on-scroll-down" = "pactl set-sink-volume @DEFAULT_SINK@ -1%";
          "on-click-right" = "pavucontrol";
        };
        backlight = {
          format = " {icon} ";
          format-icons = [
            "󱩎"
            "󱩏"
            "󱩐"
            "󱩑"
            "󱩒"
            "󱩓"
            "󱩔"
            "󱩕"
            "󱩖"
            "󰛨"
          ];
          "on-scroll-up" = "brightnessctl -n s +1%";
          "on-scroll-down" = "brightnessctl -n s 1%-";
        };
        battery = {
          interval = 10;
          states = {
            warning = 20;
            critical = 10;
          };
          format = "{icon} {capacity}%";
          "format-icons" = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
          ];
          "format-full" = "󰁹 {capacity}%";
          "format-charging" = " {capacity}%";
        };
      }
    ];
    style = builtins.readFile ./waybar-style.css;
  };
}
