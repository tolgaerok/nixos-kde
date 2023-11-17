{ config, pkgs, lib, ... }:

# NVIDIA-GPU related

{
  imports = [
    # "./nvidia-docker.nix"    # Include the necessary file for Nvidia virtualization (if needed)
    ../../openGL/opengl.nix

  ];

  hardware = {
    nvidia = {
      modesetting.enable = true;
      nvidiaPersistenced = true;

      # Enable the Nvidia settings menu
      nvidiaSettings = true;

      # Enable power management
      powerManagement.enable = true; # Fix Suspend issue

      # Select the appropriate driver version for your GPU
      package = config.boot.kernelPackages.nvidiaPackages.stable;

      # Uncomment the following lines if you need to use a specific driver version
      # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_340;
      # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_390;
    };
  };

  # Specify the Nvidia video driver for Xorg 
  services.xserver.videoDrivers = [ "nvidia" ];

  # Set environment variables related to NVIDIA graphics
  environment.variables = {
    GBM_BACKEND = "nvidia-drm";
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  # Packages related to NVIDIA graphics
  environment.systemPackages = with pkgs; [
    clinfo
    gwe
    nvtop-nvidia
    virtualglLib
    vulkan-loader
    vulkan-tools
  ];
}
