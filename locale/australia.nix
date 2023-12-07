{ config, pkgs, ... }:

{

  # -----------------------------------------------------------------
  #   Set your time zone.
  # -----------------------------------------------------------------
  time.timeZone = "Australia/Perth";

  time.ntpServers = [
    "0.nixos.pool.ntp.org"
    "1.nixos.pool.ntp.org"
    "2.nixos.pool.ntp.org"
    "3.nixos.pool.ntp.org"
    "time.google.com"
    "time2.google.com"
    "time3.google.com"
    "time4.google.com"
  ];

  # -----------------------------------------------------------------
  #   Select internationalisation properties.
  # -----------------------------------------------------------------
  i18n = {
    defaultLocale = "en_AU.UTF-8";
    supportedLocales = [
      "all"

    ];
  };

  # both location-based services and time synchronization services are active 
  services.geoclue2.enable = true;
  services.localtimed.enable = true;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  #---------------------------------------------------------------------
  # Configure keymap in X11
  #---------------------------------------------------------------------
  services.xserver = {
    layout = "au";
    xkbVariant = "";
  };

}
