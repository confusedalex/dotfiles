{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    displaylink
  ];

  services.xserver.videoDrivers = [
    "displaylink"
    "modesetting"
  ];

  systemd.services.dlm.wantedBy = [ "multi-user.target" ];

  nixpkgs.overlays = [
    (final: prev: {
      wlroots_0_18 = prev.wlroots_0_18.overrideAttrs (old: {
        patches = (old.patches or [ ]) ++ [
          (prev.fetchpatch {
            url = "https://gitlab.freedesktop.org/wlroots/wlroots/uploads/bd115aa120d20f2c99084951589abf9c/DisplayLink_v2.patch";
            hash = "sha256-vWQc2e8a5/YZaaHe+BxfAR/Ni8HOs2sPJ8Nt9pfxqiE=";
          })
        ];
      });
    })
  ];

}
