{ inputs, ... }:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];
  sops.age.keyFile = "/persist/home/alex/.config/sops/age/keys.txt";
  sops.defaultSopsFile = ../secrets.yaml;
}
