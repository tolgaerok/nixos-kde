{ config, pkgs, ... }:

# Laptop { various}
# Intel hardware video acceleration and
# VAAPI/VDPAU compatibility, which are more
# relevant for Intel and AMD GPU's

{
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  # ---------------------------------------------------------------------
  # Enable Intel GPU in NixOS
  # ---------------------------------------------------------------------
  # hardware = { i915.enable = true; };

  services.xserver = {
    videoDrivers = [ "intel" ]; # Enable Intel graphics driver
  };

  # ---------------------------------------------------------------------
  # Power management
  # ---------------------------------------------------------------------
  powerManagement.enable = true;

  # ---------------------------------------------------------------------
  # Use this instead if laptop runs HOT under tlp
  # Tell tlp to always run in battery mode
  # ---------------------------------------------------------------------

  #services.tlp = {
  #  enable = true;
  #  settings = {
  #    TLP_DEFAULT_MODE = "BAT";
  #    TLP_PERSISTENT_DEFAULT = 1;
  #  };
  #};

  # ---------------------------------------------------------------------
  # Hardware video acceleration and compatibility for Intel GPUs
  # ---------------------------------------------------------------------
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # ---------------------------------------------------------------------
  # Use this snippet if you have Hybrid graphics. Many laptops have both 
  # a dedicated and a discrete GPU {Nvidia & Intel}
  # ---------------------------------------------------------------------

  #specialisation = {
  #nvidia.configuration = {
  # Nvidia Configuration
  # services.xserver.videoDrivers = [ "nvidia" ];
  # hardware.opengl.enable = true;

  # Optionally, you may need to select the appropriate driver version for your specific GPU.
  # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  # nvidia-drm.modeset=1 is required for some wayland compositors, e.g. sway
  # hardware.nvidia.modesetting.enable = true;

  # hardware.nvidia.prime = {
  #   sync.enable = true;

  #   # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
  #   nvidiaBusId = "PCI:1:0:0";

  #   # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
  #   intelBusId = "PCI:0:2:0";
  # };
  #};
  #};

}
