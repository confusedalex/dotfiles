{ pkgs, ... }:
{
  home = {
    packages = [
      pkgs.jetbrains.idea-ultimate
    ];
    persistence."/persist/home/alex/" = {
      directories = [
        ".cache/JetBrains"
        ".config/JetBrains"
        ".jdks"
		".java" # Needed for license persistence
        ".local/share/JetBrains"
        ".m2"
        ".gradle"
      ];
      files = [ ".ideavimrc" ];
    };
  };
}
