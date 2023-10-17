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

        CPU_SCALING_GOVERNOR_ON_AC = "performance";
        CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

        CPU_MIN_PERF_ON_AC = 0;
        CPU_MAX_PERF_ON_AC = 100;
        CPU_MAX_PERF_ON_BAT = 20;

        START_CHARGE_THRESH_BAT0 = 40;
        STOP_CHARGE_THRESH_BAT0 = 50;

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
}
