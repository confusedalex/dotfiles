{ inputs, ... }:
{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    ./global
    ./features/cli
    ./features/cli/gpg.nix
    ./features/desktop/common
    ./features/desktop/common/wayland-wm
    ./features/games
    ./features/productivity
    ./features/desktop/sway
  ];

  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.persistence."/persist/home/alex" = {
    directories = [
      "Downloads"
      "Music"
      "Pictures"
      "Documents"
      "Projects"
      "Videos"
      "persist"
      ".gnupg"
      ".ssh"
      ".nixops"
      ".nixfiles"
      ".local/share/keyrings"
      ".local/share/direnv"
      ".config/sops"
      ".local/share/Steam"
    ];
    files = [ ".screenrc" ];
    allowOther = true;
  };
}
