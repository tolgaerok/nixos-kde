{ config, pkgs, stdenv, lib, ... }:

{
  # Laptop { various} 
  # Intel hardware video acceleration and 
  # VAAPI/VDPAU compatibility, which are more 
  # relevant for Intel and AMD GPU's 

  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  # Update microcode when available
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;

  # --------------------------------------------------------------------- 
  # Enable Intel GPU in NixOS 
  # ---------------------------------------------------------------------
  services.xserver = {
    videoDrivers = [ "modesetting" ]; # Enable Intel graphics driver
  };

  boot.extraModprobeConfig = ''
    #options snd_hda_intel power_save=2
    #options iwlwifi bt_coex_active=0 disable_11ac=1 swcrypto=1 uapsd_disable=1
    #options iwlmvm power_scheme=1
    #options cfg80211 cfg80211_disable_40mhz_24ghz=
  '';

  boot.kernelParams = [
    # reserve the frame-buffer as setup by the BIOS or bootloader to avoid any flickering until Xorg
    "i915.fastboot=1"
    "i915.modeset=1"

    # Making use of Framebuffer compression (FBC) can reduce power consumption while reducing memory bandwidth needed for screen refreshes
    "i915.enable_fbc=1"
    "i915.enable_psr=1"
    "i915.enable_dc=1"
  ];

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

  # Power management 
  # --------------------------------------------------------------------- 
  powerManagement.enable = true;

  # CPU performance scaling 
  # ---------------------------------------------------------------------
  services.thermald.enable = true;

  # Configure auto-cpufreq 
  # Comment all this out if there's a conflict with tlp or use one or the  
  # other (auto CPU or tlp) 
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

    # Enable tlp 
    # ---------------------------------------------------------------------
    # Enable TLP service to reduce power usage and fan noise, particularly on battery

    #services.thermald.enable = lib.mkDefault true;
    services.power-profiles-daemon.enable = false;
    services.tlp.enable = lib.mkDefault true;
    services.tlp.settings = {
      CPU_BOOST_ON_AC = "0";
      CPU_BOOST_ON_BAT = "0";
      CPU_ENERGY_PERF_POLICY_ON_AC = "balance_power";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_MAX_PERF_ON_AC = "85";
      CPU_MAX_PERF_ON_BAT = "75";
      CPU_MIN_PERF_ON_BAT = "0";
      CPU_SCALING_GOVERNOR_ON_AC = "powersave";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      SCHED_POWERSAVE_ON_BAT = "1";
      WOL_DISABLE = "Y";
    };

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

    # power management is auto-cpufreq which aims to replace tlp.  
    # When using auto-cpufreq it is therefore recommended to disable tlp as  
    # these tools are conflicting with each other. However, NixOS does allow  
    # for using both at the same time, and you therefore run them in tandem at your own risk.

  };

}
