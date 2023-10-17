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
  # hardware = {
  #   i915.enable = true;
  # };

  # Configure X server to use Intel graphics driver

  services.xserver = {
    videoDrivers = [ "intel" ]; # Enable Intel graphics driver
  };

  # ---------------------------------------------------------------------
  # Power management
  # ---------------------------------------------------------------------
  powerManagement.enable = true;

  # ---------------------------------------------------------------------
  # Hardware video acceleration and compatibility for Intel GPUs
  # ---------------------------------------------------------------------
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;

    extraPackages = with pkgs; [

      amdvlk
      intel-media-driver  # LIBVA_DRIVER_NAME=iHD
      vaapiIntel          # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl

    ];
  };

}
