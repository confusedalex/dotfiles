{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wl-clipboard
    cliphist
  ];

  services.cliphist = {
    enable = true;
  };
}
