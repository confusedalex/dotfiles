# This file defines overlays
{ inputs, ... }:
{
  # This one brings our custom packages from the 'pkgs' directory
  # additions = final: _prev: import ../pkgs final.pkgs;

  modifications = final: prev: {
    # Set the neovim package to the default package of my nixvim flake
    neovim = inputs.nixvim.packages.${final.system}.default;
  };

  stable = final: _: {
    stable = inputs.nixpkgs-stable.legacyPackages.${final.system};
  };
}
