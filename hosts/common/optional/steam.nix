{ pkgs, ... }:
{
  nixpkgs.config.allowUnfree = true;

  programs = {
    gamemode.enable = true;
    steam = {
      enable = true;
      gamescopeSession.enable = true;
      extraCompatPackages = with pkgs; [ proton-ge-bin ];
    };
  };
}
