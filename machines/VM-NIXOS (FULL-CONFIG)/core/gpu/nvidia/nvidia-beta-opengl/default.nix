{ lib, config, pkgs, ... }:

{
  #---------------------------------------------------------------------
  # Nvidia drivers - NixOS wiki and help from David Turcotte.
  # (https://davidturcotte.com)
  #
  # Runs well on my GPU: NVIDIA GeForce GT 1030/PCIe/SSE2
  #---------------------------------------------------------------------

  hardware = {
    nvidia = {
      modesetting.enable = true;
      nvidiaPersistenced = true;

      # Enable the nvidia settings menu
      nvidiaSettings = true;

      # Enable power management (do not disable this unless you have a reason to).
      # Likely to cause problems on laptops and with screen tearing if disabled.
      powerManagement.enable = true;

      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };

    # Direct Rendering Infrastructure (DRI) support, both for 32-bit and 64-bit, and 
    # Make sure opengl is enabled
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;

      # Install additional packages that improve graphics performance and compatibility.
      extraPackages = with pkgs; [

        intel-media-driver # LIBVA_DRIVER_NAME=iHD
        vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
        vaapiVdpau
        libvdpau-va-gl
        vulkan-validation-layers

      ];
    };
  };

  # Tell Xorg to use the nvidia driver (also valid for Wayland)
  services.xserver.videoDrivers = [ "nvidia" ];

  environment.variables = {
    GBM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  environment.systemPackages = with pkgs; [

    clinfo
    virtualglLib
    vulkan-loader
    vulkan-tools

  ];

}
