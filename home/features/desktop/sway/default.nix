{ pkgs, ... }:
{

  imports = [ ../common/wayland-wm/swaylock.nix ];

  home.packages = with pkgs; [
    swayidle
    networkmanagerapplet
    nwg-displays
    udiskie
    shotman
    sway-audio-idle-inhibit
  ];

  # Add flatpak to path, so it appears in bemenu
  home.sessionVariables = {
    XDG_DATA_DIRS = "$XDG_DATA_DIRS:/usr/share:/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share";
  };

  wayland.windowManager.sway = {
    enable = false;
    xwayland = true;
    config = {
      bars = [ ];
      modes = { };
      keybindings = { };
      modifier = "Mod4";
    };
    extraConfig = ''
      set $swaylock swaylock --clock --indicator -i /home/alex/.nixfiles/home/wallpapers/emacs-dawn-trans-4k.png

      # Autostart
      exec udiskie -nt
      exec blueman-applet
      exec nm-applet
      exec sway-audio-idle-inhibit
      exec emacs --daemon

      # Variables
      set $mod Mod4
      # Home row direction keys, like vim
      set $left h
      set $down j
      set $up k
      set $right l
      set $term foot
      set $menu bemenu-run -i

      ### Output configuration
      #
      # You can get the names of your outputs by running: swaymsg -t get_outputs
      #
      output "Samsung Display Corp. 0x4193 Unknown" res 2880x1800@90Hz scale 2
      output "Philips Consumer Electronics Company PHL 345B1C 0x00001C55" res 3440x1440@100Hz

      ### Idle configuration
      #
      # Example configuration:
      #
      exec swayidle -w \
        timeout 300 '$swaylock' \
        timeout 600 'swaymsg "output * power off"' resume 'swaymsg "output * power on"' \
        before-sleep '$swaylock'

      # Input configuration
      input * {
        xkb_layout "eu"
        xkb_numlock enabled
      }
      input "2:7:SynPS/2_Synaptics_TouchPad" {
        dwt disabled
        tap enabled
        natural_scroll enabled
        middle_emulation enabled
      }
      input "1739:52839:SYNA8018:00_06CB:CE67_Touchpad" {
        dwt disabled
        tap enabled
        natural_scroll enabled
        middle_emulation enabled
      }

      ### Key bindings
      #
      # Basics:
      #
      bindsym $mod+Return exec $term
      bindsym $mod+Shift+q kill
      bindsym $mod+space exec $menu
      bindsym $mod+e exec emacsclient -c
      floating_modifier $mod normal

      # Reload the configuration file
      bindsym $mod+Shift+c reload

      # Exit sway (logs you out of your Wayland session)
      bindsym $mod+Shift+e exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -B 'Yes, exit sway' 'swaymsg exit'

      #
      # Moving around:
      #

      # Move your focus around
        bindsym $mod+$left focus left
        bindsym $mod+$down focus down
        bindsym $mod+$up focus up
        bindsym $mod+$right focus right
      # Or use $mod+[up|down|left|right]
        bindsym $mod+Left focus left
        bindsym $mod+Down focus down
        bindsym $mod+Up focus up
        bindsym $mod+Right focus right

      # Move the focused window with the same, but add Shift
        bindsym $mod+Shift+$left move left
        bindsym $mod+Shift+$down move down
        bindsym $mod+Shift+$up move up
        bindsym $mod+Shift+$right move right
      # Ditto, with arrow keys
        bindsym $mod+Shift+Left move left
        bindsym $mod+Shift+Down move down
        bindsym $mod+Shift+Up move up
        bindsym $mod+Shift+Right move right
      #
      # Workspaces:
      #
      # Switch to workspace
        bindsym $mod+1 workspace number 1
        bindsym $mod+2 workspace number 2
        bindsym $mod+3 workspace number 3
        bindsym $mod+4 workspace number 4
        bindsym $mod+5 workspace number 5
        bindsym $mod+6 workspace number 6
        bindsym $mod+7 workspace number 7
        bindsym $mod+8 workspace number 8
        bindsym $mod+9 workspace number 9
        bindsym $mod+0 workspace number 10
      # Move focused container to workspace
        bindsym $mod+Shift+1 move container to workspace number 1
        bindsym $mod+Shift+2 move container to workspace number 2
        bindsym $mod+Shift+3 move container to workspace number 3
        bindsym $mod+Shift+4 move container to workspace number 4
        bindsym $mod+Shift+5 move container to workspace number 5
        bindsym $mod+Shift+6 move container to workspace number 6
        bindsym $mod+Shift+7 move container to workspace number 7
        bindsym $mod+Shift+8 move container to workspace number 8
        bindsym $mod+Shift+9 move container to workspace number 9
        bindsym $mod+Shift+0 move container to workspace number 10
      # Layout stuff:
      #
      # You can "split" the current object of your focus with
      # $mod+b or $mod+v, for horizontal and vertical splits
      # respectively.
        bindsym $mod+b splith
        bindsym $mod+v splitv

      # Make the current focus fullscreen
        bindsym $mod+f fullscreen

      # Toggle the current focus between tiling and floating mode
        bindsym $mod+Shift+space floating toggle

      # Move focus to the parent container
      bindsym $mod+a focus parent
      #
      # Scratchpad:
      #
      # Sway has a "scratchpad", which is a bag of holding for windows.
      # You can send windows there and get them back later.

      # Move the currently focused window to the scratchpad
      bindsym $mod+Shift+minus move scratchpad

      # Show the next scratchpad window or hide the focused scratchpad window.
      # If there are multiple scratchpad windows, this command cycles through them.
      bindsym $mod+minus scratchpad show
      #
      # Resizing containers:
      #
      mode "resize" {
      # left will shrink the containers width
      # right will grow the containers width
      # up will shrink the containers height
      # down will grow the containers height
        bindsym $left resize shrink width 10px
        bindsym $down resize grow height 10px
        bindsym $up resize shrink height 10px
        bindsym $right resize grow width 10px

      # Ditto, with arrow keys
        bindsym Left resize shrink width 10px
        bindsym Down resize grow height 10px
        bindsym Up resize shrink height 10px
        bindsym Right resize grow width 10px

      # Return to default mode
        bindsym Return mode "default"
        bindsym Escape mode "default"
      }
      bindsym $mod+r mode "resize"
      #
      # Utilities:
      #
      # Special keys to adjust volume via PulseAudio
      bindsym --locked XF86AudioMute exec pactl set-sink-mute \@DEFAULT_SINK@ toggle
      bindsym --locked XF86AudioLowerVolume exec pactl set-sink-volume \@DEFAULT_SINK@ -5%
      bindsym --locked XF86AudioRaiseVolume exec pactl set-sink-volume \@DEFAULT_SINK@ +5%
      bindsym --locked XF86AudioMicMute exec pactl set-source-mute \@DEFAULT_SOURCE@ toggle
      # Special keys to adjust brightness via brightnessctl
      bindsym --locked XF86MonBrightnessDown exec brightnessctl set 5%- -n
      bindsym --locked XF86MonBrightnessUp exec brightnessctl set 5%+ -n
      # Special key to take a screenshot with grim
      bindsym Print exec shotman --capture region
      bindsym $mod+n exec swaync-client -t -sw
      bindsym $mod+Escape exec $swaylock
      bindsym $mod+s move workspace to output right

      bindgesture swipe:right workspace prev
      bindgesture swipe:left workspace next

      font pango:JetbrainsMono Nerd Font Bold 12

      titlebar_padding 1
      titlebar_border_thickness 0

      # for_window [app_id=".*"] border pixel 1

      gaps inner 13
      gaps outer 2

      default_border pixel 3
      default_floating_border pixel 2

      # Clamshell mode:
      set $laptop eDP-1
      bindswitch --reload --locked lid:on output $laptop disable
      bindswitch --reload --locked lid:off output $laptop enable

      # Status Bar:
      bar {
        swaybar_command waybar
      }
    '';
  };
}
