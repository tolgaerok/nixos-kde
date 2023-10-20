{ config, pkgs, ... }:

{

  # -----------------------------------------------------------------
  #   Set your time zone.
  # -----------------------------------------------------------------
  time.timeZone = "Australia/Perth";

  # -----------------------------------------------------------------
  #   Select internationalisation properties.
  # -----------------------------------------------------------------
  i18n.defaultLocale = "en_AU.UTF-8";

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
