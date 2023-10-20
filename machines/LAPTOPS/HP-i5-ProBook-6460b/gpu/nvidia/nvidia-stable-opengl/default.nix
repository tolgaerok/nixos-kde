{ config, pkgs, lib, ... }:

with lib;

{
  #---------------------------------------------------------------------
  # Nvidia drivers - NixOS wiki and help from David Turcotte.
  # (https://davidturcotte.com)
  #
  # Runs well on my GPU: NVIDIA GeForce GT 1030/PCIe/SSE2
  #---------------------------------------------------------------------

  imports = [

    #---------------------------------------------------------------------
    # Nvidia virtulation for Docker/Virtulization
    #---------------------------------------------------------------------

    #./nvidia-docker.nix

  ];

  hardware = {
    nvidia = {
      modesetting.enable = true;
      nvidiaPersistenced = true;

      #---------------------------------------------------------------------
      # Enable the nvidia settings menu
      #---------------------------------------------------------------------

      nvidiaSettings = true;

      #---------------------------------------------------------------------
      # Enable power management (do not disable this unless you have a reason to).
      # Likely to cause problems on laptops and with screen tearing if disabled.
      #---------------------------------------------------------------------

      powerManagement.enable = true; # Fix Suspend issue

      #---------------------------------------------------------------------
      # Optionally, you may need to select the appropriate driver version for your specific GPU.
      #---------------------------------------------------------------------

      package = config.boot.kernelPackages.nvidiaPackages.stable;

      # Check legacy drivers https://www.nvidia.com/en-us/drivers/unix/legacy-gpu/
      # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_340
      # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_390
    };

    #---------------------------------------------------------------------
    # Direct Rendering Infrastructure (DRI) support, both for 32-bit and 64-bit, and 
    # Make sure opengl is enabled
    #---------------------------------------------------------------------

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;

      #---------------------------------------------------------------------
      # Install additional packages that improve graphics performance and compatibility.
      #---------------------------------------------------------------------

      extraPackages = with pkgs; [

        intel-media-driver # LIBVA_DRIVER_NAME=iHD
        libvdpau-va-gl
        nvidia-vaapi-driver
        vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
        vaapiVdpau
        vulkan-validation-layers

      ];

    };
  };

  #---------------------------------------------------------------------
  # OpenRGB && X Server Video Drivers Configuration
  # Tell Xorg to use the nvidia driver (also valid for Wayland)
  #---------------------------------------------------------------------

  services = {
    hardware.openrgb = {
      enable = true;
      motherboard = "intel";
      package = pkgs.openrgb-with-all-plugins;
    };
    xserver.videoDrivers = [ "nvidia" ];
  };

  #---------------------------------------------------------------------
  # Set environment variables related to NVIDIA graphics:
  #---------------------------------------------------------------------

  environment.variables = {
    GBM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  #---------------------------------------------------------------------
  # Packages related to NVIDIA graphics:
  #---------------------------------------------------------------------

  environment.systemPackages = with pkgs; [

    clinfo
    gwe
    nvtop-nvidia
    virtualglLib
    vulkan-loader
    vulkan-tools

  ];

}
