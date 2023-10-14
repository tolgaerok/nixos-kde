{ config, lib, pkgs, ... }:

{
  hardware = {
    opengl = {
      driSupport = true;
      driSupport32Bit = true;

      extraPackages = with pkgs; [

        amdvlk
        driversi686Linux.amdvlk
        libvdpau-va-gl
        radeontop
        rocm-opencl-icd
        rocm-opencl-runtime
        vaapiIntel
        vaapiVdpau
        xorg.xf86videoamdgpu

      ];
    };
  };
  
  # [AMD/ATI] Thames [Radeon HD 7550M/7570M/7650M]
  services.xserver.videoDrivers = [ "amdgpu" ];
}
