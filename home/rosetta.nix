{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    inputs.nur.modules.homeManager.default
    ./features/cli
    ./features/cli/gpg.nix
    ./features/desktop/common/code.nix
    ./features/desktop/common/emacs.nix
    ./features/desktop/common/firefox.nix
    ./features/desktop/common/intellij.nix
    ./features/desktop/common/jellyfin.nix
    ./features/desktop/common/office.nix
    ./features/desktop/common/school.nix
    ./features/desktop/common/signal.nix
    ./features/desktop/common/syncthing.nix
    ./features/desktop/common/wayland-wm
    ./features/desktop/sway
    ./features/games/prismlauncher.nix
    ./features/games/vintagestory.nix
    ./features/productivity/mail.nix
    ./global
  ];

  home = {
    stateVersion = "24.05";
    packages = with pkgs; [
      chromium
    ];

    persistence."/persist/home/alex" = {
      directories = [
        ".cert" # openvpn networkmanager stuff
        "Downloads"
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
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
