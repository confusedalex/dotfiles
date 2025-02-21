{
  lib,
  config,
  ...
}:
{
  imports = [
    ./sops.nix
  ];

  home = {
    username = lib.mkDefault "alex";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
  };

  nix.settings.trusted-users = [ "alex" ];

  # nixpkgs = {
  #   overlays = [
  #     # Add overlays your own flake exports (from overlays and pkgs dir):
  #     outputs.overlays.stable
  #     outputs.overlays.modifications
  #     inputs.nur.overlay
  #     # You can also add overlays exported from other flakes:
  #     # neovim-nightly-overlay.overlays.default
  #
  #     # Or define it inline, for example:
  #     # (final: prev: {
  #     #   hi = final.hello.overrideAttrs (oldAttrs: {
  #     #     patches = [ ./change-hello-to-hi.patch ];
  #     #   });
  #     # })
  #   ];
  #
  #   config = {
  #     allowUnfree = true;
  #   };
  # };
}
