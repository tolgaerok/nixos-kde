{ lib, config, pkgs, ... }:

{
  #---------------------------------------------------------------------
  # Nvidia drivers - NixOS wiki and help from David Turcotte.
  # (https://davidturcotte.com)
  #
  # Runs well on my GPU: NVIDIA GeForce GT 1030/PCIe/SSE2
  #---------------------------------------------------------------------

  # Original stable ettings
  hardware.nvidia.modesetting.enable = true;
  hardware.opengl.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;   # Works well with Nvidia GT-1030 onwards

  # -----------------------------------------------------------------------------
  # Optionally, you may need to select the appropriate driver version for your specific GPU.
  # -----------------------------------------------------------------------------

  # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;
  # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.vulkan_beta;

  # -----------------------------------------------------------------------------
  # Check legacy drivers https://www.nvidia.com/en-us/drivers/unix/legacy-gpu/
  # -----------------------------------------------------------------------------

  # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_340;
  # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_390;  # Works well with Nvidia GT-710 and below

}
