{ pkgs, ... }:
{
  home.packages = [ pkgs.vscode-fhs ];

  home.persistence."/persist/home/alex/".directories = [
    ".vscode"
    ".config/Code"
  ];
}
