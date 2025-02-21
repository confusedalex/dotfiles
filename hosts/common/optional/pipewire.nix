{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.pulseaudio
    pkgs.pavucontrol
  ];

  security.rtkit.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    wireplumber = {
      enable = true;
      configPackages = [ ];
    };
  };
}
