{ pkgs, ... }:
{
  home.packages = with pkgs; [
    sqlite
    sqlitebrowser
    ciscoPacketTracer8
    anki
    stable.zotero
  ];

  home.persistence."/persist/home/alex/".directories = [
    # Anki
    ".local/share/Anki2"

    # Packer Tracer
    "pt"

    # Zotero
    "Zotero"
    ".zotero"
  ];
}
