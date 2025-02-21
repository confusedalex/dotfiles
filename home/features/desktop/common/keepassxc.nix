{ pkgs, ... }:
{
  home = {
    packages = [ pkgs.keepassxc ];
    sessionVariables.KPXC_CONFIG_LOCAL = "/home/alex/.local/share/keepassxc/config.ini";
    persistence."/persist/home/alex/".directories = [
      ".local/share/keepassxc"
      ".config/keepassxc"
    ];
  };
}
