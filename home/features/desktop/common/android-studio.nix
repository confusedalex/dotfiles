{
  pkgs,
  ...
}:
{
  home.packages = [
    pkgs.android-studio-full
    pkgs.android-tools
  ];

  home.persistence."/persist/home/alex/".directories = [
    ".android"
    ".cache/Google"
    "Android"
  ];
}
