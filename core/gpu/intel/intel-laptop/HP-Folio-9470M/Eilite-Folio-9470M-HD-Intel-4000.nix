{ config, pkgs, lib, ... }:

with lib;

#---------------------------------------------------------------------
#   Works Well on various Intel Mesa HD GPU
#   Read: core/gpu/intel/intel-laptop/HP-Folio-9470M/HD-INTEL_COMPATABILTY.txt
#---------------------------------------------------------------------

{
  #---------------------------------------------------------------------
  # Laptop configuration
  #---------------------------------------------------------------------

  imports = [

    # ../../../../core/modules/laptop-related/autorandr.nix

  ];

  nixpkgs.config.packageOverrides = pkgs:

    {

      vaapiIntel = pkgs.vaapiIntel.override {

        enableHybridCodec = true;

      };
    };

  services = {

    # kmscon.enable = false;
    # acpid.enable = true;
    # fwupd.enable = true;
    kmscon.hwRender = true;

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
    driSupport = true;
    driSupport32Bit = true;

    extraPackages = with pkgs; [
      intel-gmmlib
      intel-media-driver
      intel-ocl
      libvdpau-va-gl
      vaapiIntel
      vaapiVdpau
    ];
  };

  #---------------------------------------------------------------------
  # Power management & Analyze power consumption on Intel-based laptops
  #---------------------------------------------------------------------
  environment.systemPackages = [ pkgs.acpi pkgs.powertop ];
  hardware.bluetooth.powerOnBoot = false;
  networking.networkmanager.wifi.powersave = true;
  services.power-profiles-daemon.enable = false;
  services.upower.enable = true;

  #---------------------------------------------------------------------
  # Enable power management (do not disable this unless you have a reason to).
  # Likely to cause problems on laptops and with screen tearing if disabled.
  #---------------------------------------------------------------------
  powerManagement.enable = true;
  powerManagement.powertop.enable = true;

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
  services.tlp.enable = true;

  services.tlp.settings = {

    # AHCI/Runtime Power Management
    AHCI_RUNTIME_PM_ON_BAT = "auto";

    # CPU Settings
    CPU_BOOST_ON_AC = 1;
    CPU_BOOST_ON_BAT = 0;
    CPU_ENERGY_PERF_POLICY_ON_AC = "ondemand";
    CPU_ENERGY_PERF_POLICY_ON_BAT = "ondemand";
    CPU_MAX_PERF_ON_AC = 100;
    CPU_MAX_PERF_ON_BAT = 75;
    CPU_MIN_PERF_ON_AC = 0;
    CPU_MIN_PERF_ON_BAT = 0;
    CPU_SCALING_GOVERNOR_ON_AC = "performance"; # Adjust as needed
    CPU_SCALING_GOVERNOR_ON_BAT = "schedutil"; # Adjust as needed
    CPU_SCALING_MAX_FREQ_ON_AC = 2350000; # Average of 2.35 GHz
    CPU_SCALING_MAX_FREQ_ON_BAT =
      1000000; # For HP ProBook 6460b (Approx. 1.0 GHz)
    CPU_SCALING_MIN_FREQ_ON_AC = 1100000; # Average of 1.1 GHz
    CPU_SCALING_MIN_FREQ_ON_BAT =
      800000; # For HP EliteBook Folio 9470m (i7 3667u) = 800 Mhz

    # GPU Settings
    INTEL_GPU_BOOST_FREQ_ON_AC = 1100;
    INTEL_GPU_BOOST_FREQ_ON_BAT = 800;
    INTEL_GPU_MAX_FREQ_ON_AC = 1100; # Max GHz frequency
    INTEL_GPU_MAX_FREQ_ON_BAT = 800;
    INTEL_GPU_MIN_FREQ_ON_AC = 300; # Min Mhz
    INTEL_GPU_MIN_FREQ_ON_BAT = 150;

    # Power Management
    NATACPI_ENABLE = 1;
    RUNTIME_PM_ON_AC = "on";
    RUNTIME_PM_ON_BAT = "auto";
    SCHED_POWERSAVE_ON_BAT = 1;

    # Sound Settings
    SOUND_POWER_SAVE_ON_AC = 0;
    SOUND_POWER_SAVE_ON_BAT = 1;

    # Battery Charging
    START_CHARGE_THRESH_BAT0 = 40;
    STOP_CHARGE_THRESH_BAT0 = 80;

    # Other Settings
    TPACPI_ENABLE = 1;
    TPSMAPI_ENABLE = 1;
    WOL_DISABLE = "Y";

  };

  # services.blueman.enable = lib.mkForce false;

  # udev.extraRules = lib.mkMerge

  # [

  # autosuspend USB devices
  #    ''ACTION=="add", SUBSYSTEM=="usb", TEST=="power/control", ATTR{power/control}="auto"''
  # autosuspend PCI devices
  #    ''ACTION=="add", SUBSYSTEM=="pci", TEST=="power/control", ATTR{power/control}="auto"''
  # disable Ethernet Wake-on-LAN
  #     ''ACTION=="add", SUBSYSTEM=="net", NAME=="enp*", RUN+="${pkgs.ethtool}/sbin/ethtool -s $name wol d"''

  #  ];

}

# Approximate conversion from Hz to GHz: 1 Hz = 1e-9 GHz
# For example, 1000000 Hz (1 MHz) is approximately 1.0 GHz
