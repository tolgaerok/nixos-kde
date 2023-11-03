{ config, pkgs, lib, ... }:

with lib;

#---------------------------------------------------------------------
# Works Well on various Intel Mesa HD GPU
#---------------------------------------------------------------------

{
  #---------------------------------------------------------------------
  # Laptop configuration
  #---------------------------------------------------------------------
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  services = {
    kmscon.hwRender = true;
    # kmscon.enable = false;
  };

  #---------------------------------------------------------------------
  # Configure keymap in X11 windowing system & Enable Intel GPU in NixOS
  #---------------------------------------------------------------------
  services.xserver = {
    videoDrivers = [ "modesetting" ]; # Use the dedicated Intel driver

    xkbVariant = "";
    libinput.enable = true;
    libinput.touchpad.tapping = false;
    libinput.touchpad.naturalScrolling = true;
    libinput.touchpad.scrollMethod = "twofinger";
    libinput.touchpad.disableWhileTyping = true;
    libinput.touchpad.clickMethod = "clickfinger";
    exportConfiguration = true;
  };

  #---------------------------------------------------------------------
  # Update microcode when available
  #---------------------------------------------------------------------
  hardware.cpu.intel.updateMicrocode =
    config.hardware.enableRedistributableFirmware;

  #---------------------------------------------------------------------
  # Additional kernel parameters
  #---------------------------------------------------------------------
  boot.kernelParams = [ "intel_pstate=ondemand" ];

  #---------------------------------------------------------------------
  # Hardware video acceleration and compatibility for Intel GPUs
  #---------------------------------------------------------------------
  hardware.opengl = {
    enable = true;
    driSupport = lib.mkDefault true;
    driSupport32Bit = lib.mkDefault true;

    extraPackages = with pkgs; [

      # nvidia-vaapi-driver
      amdvlk
      intel-gmmlib
      intel-media-driver # LIBVA_DRIVER_NAME=iHD
      intel-ocl
      libvdpau-va-gl
      vaapiIntel # LIBVA_DRIVER_NAME=i965 (older but works better for Firefox/Chromium)
      vaapiVdpau
      vulkan-validation-layers

    ];
  };

  #---------------------------------------------------------------------
  # Power management & Analyze power consumption on Intel-based laptops
  #---------------------------------------------------------------------  
  hardware.bluetooth.powerOnBoot = false;
  networking.networkmanager.wifi.powersave = true;
  services.power-profiles-daemon.enable = false;
  services.upower.enable = true;

  #---------------------------------------------------------------------
  # Enable power management (do not disable this unless you have a reason to).
  # Likely to cause problems on laptops and with screen tearing if disabled.
  #---------------------------------------------------------------------
  powerManagement.enable = true;
  powerManagement.powertop.enable = lib.mkForce true;

  #---------------------------------------------------------------------
  # CPU performance scaling
  #---------------------------------------------------------------------
  services.thermald.enable = true;

  #---------------------------------------------------------------------
  # Disable auto-cpufreq to prevent conflicts
  #---------------------------------------------------------------------
  services.auto-cpufreq.enable = false;

  #---------------------------------------------------------------------
  # Enable TLP for better power management with Schedutil governor
  #---------------------------------------------------------------------
  services.tlp = {
    enable = true;

    settings = {

      # DISK_DEVICES must be specified for AHCI_RUNTIME_PM settings to work right.
      DISK_DEVICES = "nvme0n1 nvme1n1 sda sdb";

      # with AHCI_RUNTIME_PM_ON_AC/BAT set to defaults in battery mode, P51
      # can't resume from sleep and P50 can't go to sleep.
      AHCI_RUNTIME_PM_ON_AC = "on";
      AHCI_RUNTIME_PM_ON_BAT = "on";
      # AHCI_RUNTIME_PM_ON_BAT = "auto";

      # with RUNTIME_PM_ON_BAT/AC set to defaults, P50/P51 can't go to sleep
      # RUNTIME_PM_ON_AC = "on";
      # RUNTIME_PM_ON_BAT = "on";
      # RUNTIME_PM_ON_BAT = "auto";

      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;

      CPU_ENERGY_PERF_POLICY_ON_AC = "ondemand";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "ondemand";

      CPU_MAX_PERF_ON_AC = 99;
      CPU_MAX_PERF_ON_BAT = 75;
      CPU_MIN_PERF_ON_BAT = 75;

      CPU_SCALING_GOVERNOR_ON_AC = "schedutil"; # Adjust as needed
      CPU_SCALING_GOVERNOR_ON_BAT = "schedutil"; # Adjust as needed

      NATACPI_ENABLE = 1;

      RUNTIME_PM_ON_AC = "on";
      RUNTIME_PM_ON_BAT = "on"; # or auto

      SCHED_POWERSAVE_ON_BAT = 1;

      SOUND_POWER_SAVE_ON_AC = 0;
      SOUND_POWER_SAVE_ON_BAT = 1;

      START_CHARGE_THRESH_BAT0 = 40;
      STOP_CHARGE_THRESH_BAT0 = 80;

      TPACPI_ENABLE = 1;
      TPSMAPI_ENABLE = 1;

      WOL_DISABLE = "Y";
    };
  };
  #---------------------------------------------------------------------
  # Extra laptop packages
  #---------------------------------------------------------------------
  environment.systemPackages = with pkgs; [
    acpi
    cpufrequtils
    cpupower-gui
    powerstat
    powertop
    tlp
  ];
}