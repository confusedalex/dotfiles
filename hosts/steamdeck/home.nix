{
  config,
  pkgs,
  inputs,
  ...
}:
{
  home.username = "alex";
  home.homeDirectory = "/home/alex";
  home.stateVersion = "23.11"; # Please read the comment before changing.

  imports = [
    ../../modules/home-manager/terminal/default.nix
    ../../modules/home-manager/cli/default.nix
    inputs.nix-colors.homeManagerModules.default
  ];

  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-soft;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.webcord
    pkgs.keepassxc
  ];

  services.syncthing.enable = true;

  programs.home-manager.enable = true;
  programs.firefox.enable = true;

  programs.git = {
    enable = true;
    userName = "ConfusedAlex";
    userEmail = "alex@confusedserver.de";
  };
}
