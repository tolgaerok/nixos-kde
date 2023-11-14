{ config, pkgs, lib, ... }:

{
  # Enable the D-Bus service, which is a message bus system that allows
  # communication between applications.
  # Thanks Chris Titus!
  services = {
    dbus = {
      enable = true;
      packages = with pkgs; [

        dconf
        gcr
        udisks2

      ];
    };
  };
}
