{ lib, config, pkgs, ... }:

{
  #---------------------------------------------------------------------
  # Nvidia drivers - NixOS wiki and help from David Turcotte.
  # (https://davidturcotte.com)
  #---------------------------------------------------------------------
  hardware = {
    nvidia = {
      modesetting.enable = true;
      nvidiaPersistenced = true;
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver  # LIBVA_DRIVER_NAME=iHD
        vaapiIntel          # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
        vaapiVdpau
        libvdpau-va-gl
        vulkan-validation-layers
      ];
    };
  };

  # Uncomment the line below if you want to use Nvidia drivers as the default video driver
  # services.xserver.videoDrivers = [ "nvidia" ];
}
