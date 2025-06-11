{
  lib,
  inputs,
  ...
}:
{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    inputs.nur.hmModules.nur
    ./global
    ./features/cli
    # ./features/cli/gpg.nix
    ./features/desktop/common
    # ./features/desktop/common/wayland-wm
    # ./features/desktop/hyprland
    ./features/games
    ./features/productivity
  ];

  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.persistence = lib.mkForce { };

  # home.persistence."/persist/home/alex/" = {
  #   directories = [
  #     "Downloads"
  #     "Music"
  #     "Pictures"
  #     "Documents"
  #     "Projects"
  #     "Videos"
  #     ".gnupg"
  #     ".ssh"
  #     ".nixops"
  #     ".nixfiles"
  #     ".local/share/keyrings"
  #     ".local/share/direnv"
  #     ".config/sops"
  #     {
  #       directory = ".local/share/Steam";
  #       method = "symlink";
  #     }
  #   ];
  #   files = [ ".screenrc" ];
  #   allowOther = true;
  # };
}
