{ config, pkgs, lib, ... }:

###############################################################################
##      Works Well on HP Eilite Folio 9470M i7-3667u x 4 HD Intel GPU 4000   ##
###############################################################################

{
  # Laptop configuration
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  # Update microcode when available
  hardware.cpu.intel.updateMicrocode =
    config.hardware.enableRedistributableFirmware;

  # Enable Intel GPU in NixOS
  services.xserver = {
    videoDrivers = [ "modesetting" ]; # Enable Intel graphics driver
  };

  # Additional kernel parameters
  boot.kernelParams = [
    "i915.fastboot=1"
    "i915.modeset=1"
    "i915.enable_fbc=1"
    "i915.enable_psr=1"
    "i915.enable_dc=1"
  ];

  # Hardware video acceleration and compatibility for Intel GPUs
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      vaapiIntel # LIBVA_DRIVER_NAME=i965 (better for Firefox/Chromium)
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # Power management
  powerManagement.enable = true;

  boot.initrd.availableKernelModules = [ "thinkpad_acpi" ];
  services.power-profiles-daemon.enable = false;

  # CPU performance scaling
  services.thermald.enable = true;

  # Configure auto-cpufreq
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

  };

  # Enable TLP for better power management
  services.tlp.enable = false;

  services.tlp.settings = {

    # CPU_BOOST_ON_BAT = "0";
    # CPU_BOOST_ON_AC = "0";
    # CPU_SCALING_GOVERNOR_ON_AC = schedutil;
    # CPU_SCALING_GOVERNOR_ON_BAT = schedutil;
    CPU_BOOST_ON_AC = 1;
    CPU_BOOST_ON_BAT = 0;
    CPU_ENERGY_PERF_POLICY_ON_AC = "balance_power";
    CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
    CPU_MAX_PERF_ON_AC = 85;
    CPU_MAX_PERF_ON_BAT = 75;
    CPU_MIN_PERF_ON_BAT = 0;
    CPU_SCALING_GOVERNOR_ON_AC = "powersave";
    CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    NATACPI_ENABLE = 1;
    RUNTIME_PM_ON_AC = "on";
    RUNTIME_PM_ON_BAT = "auto";
    SCHED_POWERSAVE_ON_BAT = 1;
    SOUND_POWER_SAVE_ON_AC = 0;
    SOUND_POWER_SAVE_ON_BAT = 1;
    START_CHARGE_THRESH_BAT0 = 100;
    STOP_CHARGE_THRESH_BAT0 = 100;
    TPACPI_ENABLE = 1;
    TPSMAPI_ENABLE = 1;
    WOL_DISABLE = "Y";

  };

  # services.blueman.enable = lib.mkForce false;

}
