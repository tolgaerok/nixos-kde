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

  # $ nix-shell -p pciutils --run "lspci -nn | grep VGA"
  # 00:02.0 VGA compatible controller [0300]: Intel Corporation Alder Lake-UP3 GT2 [Iris Xe Graphics] [8086:46a8] (rev 0c)
  # In this example, "46a8" is the device ID. You can then add this to your configuration and reboot:
  # boot.kernelParams = [ "i915.force_probe=<device ID>" ];

  # ---------------------------------------------------------------------
  # Power management
  # ---------------------------------------------------------------------
  powerManagement.enable = true;

  # ---------------------------------------------------------------------
  # CPU performance scaling
  # ---------------------------------------------------------------------
  services.thermald.enable = true;

  # ---------------------------------------------------------------------
  # Enable tlp
  # ---------------------------------------------------------------------
  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;

      # This enables tlp and sets the minimum and maximum frequencies
      # for the cpu based on whether it is plugged into power or not. It also 
      # changes the cpu scaling governor based on this.

    };
  };

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
  # Configure auto-cpufreq
  # Comment all this out if theres a conflict with tlp or use one or the 
  # other (auto cpu or tlp)
  # ---------------------------------------------------------------------

  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "powersave";
      turbo = "never";
    };
    charger = {
      governor = "performance";
      turbo = "auto";
    };

    # power management is auto-cpufreq which aims to replace tlp. 
    # When using auto-cpufreq it is therefore recommended to disable tlp as 
    # these tools are conflicting with each other. However, NixOS does allow 
    # for using both at the same time, and you therefore run them in tandem at your own risk.

  };

  # ---------------------------------------------------------------------
  # Hardware video acceleration and compatibility for Intel GPUs
  # ---------------------------------------------------------------------
  hardware = {
    nvidia = {
      prime = {
        offload.enable = true; # enable to use intel gpu (hybrid mode)
        # sync.enable = true; # enable to use nvidia gpu (discrete mode)
        intelBusId = "PCI:0:2:0";
        nvidiaBusId = "PCI:1:0:0";
      };

      modesetting.enable = false;

    };

    opengl = {
      enable = true;
      driSupport = lib.mkDefault true;
      driSupport32Bit = lib.mkDefault true;
      
      extraPackages = with pkgs; [

        amdvlk
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
        libvdpau-va-gl
        vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
        vaapiVdpau

      ];
    };
  };

  # ---------------------------------------------------------------------
  # Use this below snippet only if you have Hybrid graphics. Many laptops have both 
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
