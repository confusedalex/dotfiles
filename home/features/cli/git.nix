{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gh
    git-annex
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
    signing.key = "4F279B9B08BE3E11";

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

  home.persistence."/persist/home/alex".directories = [
    # github cli
    ".config/gh"
  ];
}
