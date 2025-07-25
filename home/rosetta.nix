{
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
    inputs.nur.modules.homeManager.default
    ./features/games/vintagestory.nix
    ./features/cli
    ./features/cli/gpg.nix
    ./features/cli/rclone.nix
    ./features/desktop/common/chromium.nix
    ./features/desktop/common/code.nix
    ./features/desktop/common/emacs.nix
    ./features/desktop/common/firefox.nix
    ./features/desktop/common/intellij.nix
    ./features/desktop/common/jellyfin.nix
    ./features/desktop/common/office.nix
    ./features/desktop/common/programming/flutter.nix
    ./features/desktop/common/school.nix
    ./features/desktop/common/signal.nix
    ./features/desktop/common/syncthing.nix
    ./features/desktop/common/thunderbird.nix
    ./features/desktop/common/tor-browser.nix
    ./features/desktop/common/vesktop.nix
    ./features/desktop/common/wayland-wm
    ./features/desktop/niri
    ./features/games/prismlauncher.nix
    ./features/productivity/mail.nix
    ./global
  ];

  home = {
    stateVersion = "24.05";

    persistence."/persist/home/alex/" = {
      enable = false;
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
        ".config/niri"
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

  gtk = {
    enable = true;
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };

}
