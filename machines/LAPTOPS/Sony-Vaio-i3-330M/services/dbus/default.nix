# ---------------------------------------------------------------------
# Enables the D-Bus service, which is a message bus system that allows 
# communicaflatpak-packages.nixtion between applications
# Thanks Chris Titus!
#---------------------------------------------------------------------

{
  services.dbus.enable = true;
}
