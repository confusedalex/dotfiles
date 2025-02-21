{ pkgs, ... }:
{
  imports = [
    ./atuin.nix
    ./direnv.nix
    ./fish.nix
    ./git.nix
    ./helix.nix
    ./newsboat.nix
    ./nix-index.nix
    ./nvim.nix
    ./starship.nix
    ./tmux.nix
    ./yazi.nix
    ./zoxide.nix
  ];
  home.packages = with pkgs; [
    btop # Better top
    dua # Disk usage analyzer
    fastfetch # System stats like neofetch
    fd # Better find
    mosh # SSH but over UDP
    restic # Backup tool
    ripgrep # Better grep
    trash-cli # Move files to trash
    unzip # Utility for unzipping
  ];

  programs.bash.enable = true;
  programs.eza = {
    enable = true;
    icons = "auto";
  };
}
