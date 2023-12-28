{ config, pkgs, lib, ... }:

# NVIDIA-GPU related

{
  imports = [
    # "./nvidia-docker.nix"    # Include the necessary file for Nvidia virtualization (if needed)
    ../../openGL/opengl.nix
    ../included/cachix.nix
    ./vaapi.nix

  ];

  # ++ (myLib.filesIn ./included);

  hardware = {
    enableAllFirmware = true;
    nvidia = {
      modesetting.enable = true;
      nvidiaPersistenced = true;

      # Enable the Nvidia settings menu
      nvidiaSettings = true;

      # Enable power management
      powerManagement.enable = true; # Fix Suspend issue

      # Select the appropriate driver version for your GPU
      package = config.boot.kernelPackages.nvidiaPackages.production;
      # package = config.boot.kernelPackages.nvidiaPackages.stable;

      # Uncomment the following lines if you need to use a specific driver version
      # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_340;
      # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_390;

      vaapi = {
        enable = true;
        firefox.enable = true;
      };

      #---------------------------------------------------------------------
      # Fix screen flipping to black randomly (545x)      
      # (WORKS WELL: 535.86.05 (STABLE) https://download.nvidia.com/XFree86/Linux-x86_64/535.86.05/NVIDIA-Linux-x86_64-535.86.05.run
      # cat /proc/driver/nvidia/version
      #---------------------------------------------------------------------
      # package = config.boot.kernelPackages.nvidiaPackages.stable.overrideAttrs {
      #  src = pkgs.fetchurl {
      #    url = "https://download.nvidia.com/XFree86/Linux-x86_64/535.146.02/NVIDIA-Linux-x86_64-535.146.02.run";
      #   sha256 = sha256_64bit;
      #   sha256 = "49fd1cc9e445c98b293f7c66f36becfe12ccc1de960dfff3f1dc96ba3a9cbf70";
      #   # sha256 = "sha256-QTnTKAGfcvKvKHik0BgAemV3PrRqRlM3B9jjZeupCC8=";
      #  };
      # };
    };
  };

  boot.extraModprobeConfig = "options nvidia " + lib.concatStringsSep " " [
    # nvidia assume that by default your CPU does not support PAT,
    # but this is effectively never the case in 2023
    "NVreg_UsePageAttributeTable=1"
    # This may be a noop, but it's somewhat uncertain
    "NVreg_EnablePCIeGen3=1"
    # This is sometimes needed for ddc/ci support, see
    # https://www.ddcutil.com/nvidia/
    #
    # Current monitor does not support it, but this is useful for
    # the future
    "NVreg_RegistryDwords=RMUseSwI2c=0x01;RMI2cSpeed=100"
    # When (if!) I get another nvidia GPU, check for resizeable bar
    # settings
  ];

  # Replace a glFlush() with a glFinish() - this prevents stuttering
  # and glitching in all kinds of circumstances for the moment.
  #
  # Apparently I'm waiting for "explicit sync" support, which needs to
  # land as a wayland thing. I've seen this work reasonably with VRR
  # before, but emacs continued to stutter, so for now this is
  # staying.
  nixpkgs.overlays = [
    (_: final: {
      wlroots_0_16 = final.wlroots_0_16.overrideAttrs
        (_: { patches = [ ./wlroots-nvidia.patch ]; });
    })
  ];

  # Set environment variables related to NVIDIA graphics
  environment.variables = {
    # Required to run the correct GBM backend for nvidia GPUs on wayland
    GBM_BACKEND = "nvidia-drm";
    # Apparently, without this nouveau may attempt to be used instead
    # (despite it being blacklisted)
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    # Hardware cursors are currently broken on nvidia
    LIBVA_DRIVER_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
    __GL_THREADED_OPTIMIZATION = "1";
    __GL_SHADER_CACHE = "1";

  };

  # Specify the Nvidia video driver for Xorg 
  services.xserver.videoDrivers = [ "nvidia" ];

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
