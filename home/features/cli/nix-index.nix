{
  inputs,
  ...
}:
{
  imports = with inputs; [
    nix-index-database.hmModules.nix-index
  ];

  programs.nix-index = {
    enable = true;
    enableBashIntegration = true;
  };
  programs.nix-index-database.comma.enable = true;
}
