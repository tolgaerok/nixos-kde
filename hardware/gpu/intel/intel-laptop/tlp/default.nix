{ config, lib, ... }: {

  # ---------------------------------------------------------------------
  # Enable tlp
  # ---------------------------------------------------------------------
  # This enables tlp and sets the minimum and maximum frequencies
  # for the cpu based on whether it is plugged into power or not. It also 
  # changes the cpu scaling governor based on this.

  services = {
    tlp = {
      enable = false;
      settings = {

        CPU_BOOST_ON_AC = 1;
        CPU_BOOST_ON_BAT = 0;
        CPU_SCALING_GOVERNOR_ON_AC = "schedutil";
        CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
        START_CHARGE_THRESH_BAT0 = "99";
        START_CHARGE_THRESH_BAT1 = "99";
        STOP_CHARGE_THRESH_BAT0 = "100";
        STOP_CHARGE_THRESH_BAT1 = "100";

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

      };
    };
  };

  #  powerManagement.cpuFreqGovernor = "schedutil";
  services.thermald.enable = true;
  
}
