{ config, lib, pkgs, ... }:

{
  # Enable Bumblebee for NVIDIA Optimus support
  hardware.bumblebee.enable = true;
  hardware.bumblebee.driver = "nvidia";
  hardware.bumblebee.pmMethod = "bbswitch";

  # Define an overlay to make necessary adjustments
  nixpkgs.overlays = [
    (self: super: {
      bumblebee = super.bumblebee.overrideAttrs
        (oldAttrs: { meta = oldAttrs.meta // { broken = false; }; });

      # Adjust the NVIDIA driver package
      nvidiaPackages = super.nvidiaPackages // {
        legacy390 = super.nvidia_x11_legacy390;
      };

      # Enable Steam with Primus and extra packages
      steam = super.steam.override {
        withPrimus = true;
        extraPkgs = pkgs: [ pkgs.bumblebee pkgs.glxinfo ];
      };
    })
  ];
}
