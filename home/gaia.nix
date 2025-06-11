{ inputs, lib, ... }:
{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    ./global
    ./features/cli
    ./features/desktop/common/emacs.nix
  ];

  home.stateVersion = "23.11"; # Please read the comment before changing.

  stylix.enable = lib.mkForce false;

  home.persistence."/persist/home/alex/" = {
    directories = [
      "Downloads"
      "docker"
      ".gnupg"
      ".ssh"
      ".nixops"
      ".nixfiles"
      ".local/share/keyrings"
      ".local/share/direnv"
      ".config/sops"
    ];
    files = [ ".screenrc" ];
    allowOther = true;
  };
}
