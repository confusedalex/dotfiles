{ pkgs, ... }:
{
  home = {
    packages = [
      pkgs.jetbrains.idea-community-bin
    ];
    persistence."/persist/home/alex/" = {
      directories = [
        ".cache/JetBrains"
        ".config/JetBrains"
        ".jdks"
        ".local/share/JetBrains"
        ".m2"
        ".gradle"
      ];
      files = [ ".ideavimrc" ];
    };
  };
}
