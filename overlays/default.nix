# This file defines overlays
{ inputs, ... }:
{
  # This one brings our custom packages from the 'pkgs' directory
  # additions = final: _prev: import ../pkgs final.pkgs;

  modifications = final: prev: {
    # Set the neovim package to the default package of my nixvim flake
    neovim = inputs.nixvim.packages.${final.system}.default;

    cliphist = prev.cliphist.overrideAttrs (_old: {
      src = final.fetchFromGitHub {
        owner = "sentriz";
        repo = "cliphist";
        rev = "c49dcd26168f704324d90d23b9381f39c30572bd";
        sha256 = "sha256-2mn55DeF8Yxq5jwQAjAcvZAwAg+pZ4BkEitP6S2N0HY=";
      };
      vendorHash = "sha256-M5n7/QWQ5POWE4hSCMa0+GOVhEDCOILYqkSYIGoy/l0=";
    });
  };

  stable = final: _: {
    stable = inputs.nixpkgs-stable.legacyPackages.${final.system};
  };
}
