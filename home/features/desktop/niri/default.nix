{pkgs, ...}:
{
  imports = [
	../common/wayland-wm/swaylock.nix
  ];

  home.packages = with pkgs; [
	swaybg
	networkmanagerapplet
    nwg-displays
    udiskie
    sway-audio-idle-inhibit
  ];

  home.file.".config/niri/config.kdl".source = ./niri.kdl;
}
