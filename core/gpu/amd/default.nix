{ config, pkgs, lib, ... }:

# AMD-GPU related

{
  imports = [
    # ./amdgpu-pro.nix
    ../../openGL/opengl.nix

  ];

  # Packages related to AMD-GPU graphics
  environment.systemPackages = with pkgs; [
    amdvlk
    driversi686Linux.amdvlk
    radeontop
    rocm-opencl-icd
    rocm-opencl-runtime
    xorg.xf86videoamdgpu

  ];

  #enableRedistributableFirmware = true;

  # [AMD/ATI] Thames [Radeon HD 7550M/7570M/7650M]
  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
}
