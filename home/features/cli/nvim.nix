{
  pkgs,
  ...
}:
{
  stylix.targets.vim.enable = false;
  stylix.targets.neovim.enable = false;

  home = {
    packages = [ pkgs.neovim ];

    shellAliases.vim = "nvim";
    shellAliases.vi = "nvim";

    sessionVariables.EDITOR = "nvim";

    persistence."/persist/home/alex".directories = [
      ".config/nvim"
      ".local/share/nvim"
      ".config/github-copilot/" # github-copilot plugin for nvim
    ];
  };
}
