{
  programs.mosh.enable = true;
  services.openssh = {
    enable = true;
  };

  environment.persistence."/persist".directories = [
    "/etc/ssh"
  ];
}
