{
  outputs,
  inputs,
  ...
}:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ./gruvbox.nix
    ./locale.nix
    ./nh.nix
    ./nix-ld.nix
    ./sops.nix
    ./ssh.nix
    ./tailscale.nix
  ];

  programs.fish.enable = true;

  home-manager.extraSpecialArgs = {
    inherit inputs outputs;
  };

  nixpkgs = {
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      inputs.nur.overlay
      outputs.overlays.modifications
      outputs.overlays.stable
      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default
    ];

    config = {
      allowUnfree = true;
    };
  };
}
