{ config, pkgs, ... }:

#---------------------------------------------------------------------
# Tolga Erok
# 22/10/23
# appimage-registration for KDE Plasma
#
# ¯\_(ツ)_/¯
#---------------------------------------------------------------------

{
  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = "\\xff\\xff\\xff\\xff\\x00\\x00\\x00\\x00\\xff\\xff\\xff";
    magicOrExtension = "\\x7fELF....AI\\x02";
  };
}
