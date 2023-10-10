{ pkgs, ... }: {

  # Miscellaneous laptop pkgs

  environment = {
    systemPackages = with pkgs; [

      cpufrequtils      # cpufreq-info cpufreq-set cpufreq-aperf
      cpupower-gui      # cpupower-gui 
      powerstat         # powerstat
      tlp               # wwan bluetooth nfc run-on-bat wifi tlp-stat run-on-ac tlp


    ];
  };
} 
