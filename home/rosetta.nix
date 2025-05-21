{
  inputs,
  ...
}:
{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    inputs.nur.modules.homeManager.default
    ./features/cli
    ./features/cli/gpg.nix
    ./features/cli/rclone.nix
    ./features/desktop/common/chromium.nix
    ./features/desktop/common/code.nix
    ./features/desktop/common/emacs.nix
    ./features/desktop/common/intellij.nix
    ./features/desktop/common/librewolf.nix
    ./features/desktop/common/jellyfin.nix
    ./features/desktop/common/office.nix
    ./features/desktop/common/firefox.nix
    ./features/desktop/common/school.nix
    ./features/desktop/common/signal.nix
    ./features/desktop/common/syncthing.nix
    ./features/desktop/common/wayland-wm
    ./features/desktop/common/android-studio.nix
    ./features/desktop/common/vesktop.nix
    ./features/desktop/sway
    ./features/games/prismlauncher.nix
    ./features/games/vintagestory.nix
    ./features/productivity/mail.nix
    ./global
  ];

  home = {
    stateVersion = "24.05";

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
        ".local/share/nix" # trusted settings and repl history
        ".config/hypr"
      ];
      files = [
        ".screenrc"
        ".config/mimeapps.list"
      ];
      allowOther = true;
    };
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
}
