{ config, pkgs, ... }:

let nixpkgs = import <nixpkgs> { };
in {
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
    # nvidia_x11 = pkgs.nvidia_x11.override { enableGeforce1030 = true; };
  };
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
      # nvidia_x11          # Nvidia X11 driver for GT1030
    ];
  };
}
