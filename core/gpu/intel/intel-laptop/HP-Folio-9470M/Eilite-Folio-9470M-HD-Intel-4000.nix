{ config, pkgs, lib, ... }:

###############################################################################
##      Works Well on HP Eilite Folio 9470M i7-3667u x 4 HD Intel GPU 4000   ##
###############################################################################

{
  # Laptop configuration
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
  };

  # For Laptop
  libinput = {
    enable = true;
    touchpad.clickMethod = "clickfinger";
    touchpad.disableWhileTyping = true;
    touchpad.naturalScrolling = true;
    touchpad.scrollMethod = "twofinger";
    touchpad.tapping = true;
  };

  # Update microcode when available
  hardware.cpu.intel.updateMicrocode =
    config.hardware.enableRedistributableFirmware;

  # Enable Intel GPU in NixOS
  services.xserver = {
    videoDrivers = [ "intel" ]; # Use the dedicated Intel driver
  };

  # Additional kernel parameters
  boot.kernelParams = [
    #  "i915.enable_dc=1"
    #  "i915.enable_fbc=1"
    #  "i915.enable_psr=1"
    #  "i915.modeset=1"
    #  "i915.fastboot=1"    
  ];

  # Hardware video acceleration and compatibility for Intel GPUs
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  # Power management
  powerManagement.enable = true;
  services.upower.enable = true;

  # CPU performance scaling
  services.thermald.enable = true;

  # Disable auto-cpufreq to prevent conflicts
  services.auto-cpufreq.enable = false;

  # Enable TLP for better power management with Schedutil governor
  services.tlp.enable = true;

  services.tlp.settings = {

    AHCI_RUNTIME_PM_ON_BAT= "auto";
    CPU_BOOST_ON_AC = 1;
    CPU_BOOST_ON_BAT = 0;
    CPU_ENERGY_PERF_POLICY_ON_AC = "balance_power";
    CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
    CPU_MAX_PERF_ON_AC = 99;
    CPU_MAX_PERF_ON_BAT = 75;
    CPU_MIN_PERF_ON_BAT = 75;
    CPU_SCALING_GOVERNOR_ON_AC = "schedutil"; # Adjust as needed
    CPU_SCALING_GOVERNOR_ON_BAT = "schedutil"; # Adjust as needed
    NATACPI_ENABLE = 1;
    RUNTIME_PM_ON_AC = "on";
    RUNTIME_PM_ON_BAT = "auto";
    SCHED_POWERSAVE_ON_BAT = 1;
    SOUND_POWER_SAVE_ON_AC = 0;
    SOUND_POWER_SAVE_ON_BAT = 1;
    START_CHARGE_THRESH_BAT0 = 40;
    STOP_CHARGE_THRESH_BAT0 = 80;
    TPACPI_ENABLE = 1;
    TPSMAPI_ENABLE = 1;
    WOL_DISABLE = "Y";

  };

  # services.blueman.enable = lib.mkForce false;

  environment.systemPackages = [ pkgs.acpi ];
  hardware.bluetooth.powerOnBoot = false;
  networking.networkmanager.wifi.powersave = true;

}
