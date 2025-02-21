{ pkgs, ... }:
{
  home.packages = with pkgs; [
    sqlite
    sqlitebrowser
    ciscoPacketTracer8
    anki
  ];

  home.persistence."/persist/home/alex/".directories = [
    ".local/share/Anki2"
    "pt"
  ];
}
