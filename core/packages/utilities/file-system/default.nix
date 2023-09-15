{ config, pkgs, lib, ... }:

{
  #---------------------------------------------------------------------
  # File Systems and Archiving:
  #---------------------------------------------------------------------

  environment = {
    systemPackages = with pkgs; [

      # Libraries
      libarchive
      libbtbb
      libnotify # Desktop Notify agent example: notify-send --icon=fcitx --app-name="DONE" "Fonts folder copied into $(whoami)" "$font_dest" -u normal
      notify-desktop # Desktop Notify agent example: notify-desktop --icon=call-start "Incoming call"   SOURCE: https://github.com/nowrep/notify-desktop/tree/master
      
    ];
  };
}
