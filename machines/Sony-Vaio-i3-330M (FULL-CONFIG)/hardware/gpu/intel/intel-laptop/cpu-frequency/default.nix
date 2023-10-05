{ config, lib, ... }:

{
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
}
