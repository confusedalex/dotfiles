{ inputs, ... }:
{
  imports = [ inputs.sops-nix.homeManagerModules.sops ];
  sops.age.keyFile = "/persist/home/alex/.config/sops/age/keys.txt";
  sops.defaultSopsFile = ../features/secrets.yaml;
}
