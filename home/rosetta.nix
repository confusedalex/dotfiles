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
    ./features/desktop/common/firefox.nix
    ./features/desktop/common/intellij.nix
    ./features/desktop/common/emacs.nix
    # ./features/desktop/common/jellyfin.nix
    # ./features/desktop/common/josm.nix
    # ./features/desktop/common/obsidian.nix
    ./features/desktop/common/office.nix
    ./features/desktop/common/school.nix
    ./features/desktop/common/signal.nix
    ./features/desktop/common/syncthing.nix
    ./features/desktop/common/wayland-wm
    ./features/desktop/common/wayland-wm/foot.nix
    ./features/desktop/common/wayland-wm/kitty.nix
    ./features/desktop/sway
    ./features/games/prismlauncher.nix
    ./features/productivity/mail.nix
    # ./features/productivity/khal.nix
    ./global
  ];
  programs = {
    bash.enable = true; # Please read the comment before changing.
    home-manager.enable = true;

    thunderbird = {
      enable = true;
      profiles = {
        "private" = {
          isDefault = true;
          withExternalGnupg = true;
        };
      };
    };
  };
  home = {
    stateVersion = "24.05";
    packages = with pkgs; [
      rocketchat-desktop
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
