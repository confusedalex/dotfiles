{ pkgs, ... }:
{
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
    package = pkgs.docker_25;
  };
  virtualisation.oci-containers.backend = "docker";

  environment.persistence."/persist".directories = [
    "/var/lib/docker/"
  ];
}
