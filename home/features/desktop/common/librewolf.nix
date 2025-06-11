_:
{
  programs.librewolf = {
    enable = true;
  };

  home = {
    persistence."/persist/home/alex/".directories = [ ".librewolf" ];
  };
}
