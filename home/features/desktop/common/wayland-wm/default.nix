{
  imports = [
    ./bemenu.nix
    ./cliphist.nix
    ./imv.nix
    ./foot.nix
    ./swaync.nix
    ./waybar.nix
    ./wlsunset.nix
    ./wlsunset.nix
    ./zathura.nix
  ];

  services.playerctld.enable = true;
  services.mpris-proxy.enable = true;
}
