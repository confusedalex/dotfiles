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
    ./features/cli/gpg.nix
    ./features/desktop/common
    ./features/desktop/common/wayland-wm
    # ./features/desktop/hyprland
    ./features/productivity
    ./features/desktop/sway
  ];

  home.stateVersion = "23.11"; # Please read the comment before changing.

  home.persistence = lib.mkForce { };
}
