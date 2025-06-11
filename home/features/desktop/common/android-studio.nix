{
  pkgs,
  ...
}:
{
  home.packages = [
    pkgs.android-studio
  ];

  home.persistence."/persist/home/alex/".directories = [
    ".android"
    ".cache/Google"
    "Android"
  ];
}
