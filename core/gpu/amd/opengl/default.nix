{ config, lib, pkgs, ... }: {
  hardware = {
    opengl = {
      driSupport = true;
      driSupport32Bit = true;

      extraPackages = with pkgs; [
        amdvlk
        libvdpau-va-gl
        vaapiIntel
        vaapiVdpau

      ];
    };

    # default settings
    videoDrivers = [
      "amdgpu"
      "radeon"
      # "nouveau"
      "modesetting"
      "fbdev"
    ];

  };

}
