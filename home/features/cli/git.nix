{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gh
  ];

  programs.lazygit = {
    enable = true;
    settings = {
      git = {
        overrideGpg = true;
      };
    };
  };

  programs.git = {
    enable = true;
    signing.signByDefault = true;
    extraConfig = {
      rerere.enable = true;
    };
    userName = "confusedalex";
    userEmail = "alex@confusedalex.dev";
    signing.key = "05AF71643F6E2ED3";

    includes = [
      {
        condition = "gitdir:~/persist/projects/work/";
        contents = {
          user = {
            name = "Alexander Loll";
            email = "a.loll@qvest-digital.com";
            signingKey = "~/.ssh/work.pub";
          };
          gpg.format = "ssh";
        };
      }
    ];
  };
}
