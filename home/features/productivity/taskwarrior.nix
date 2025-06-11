{ pkgs, ... }:
{
  home.packages = with pkgs; [
    taskwarrior-tui
  ];
  programs.taskwarrior = {
    enable = true;
    package = pkgs.taskwarrior3;
  };

  home.persistence."/persist/home/alex/".directories = [ ".local/share/task" ];

  programs.fish.shellAbbrs = {
    tt = "taskwarrior-tui";
  };
}
