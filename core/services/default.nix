{ ... }: {

  imports = [
    # ------------------------------------------
    # Configuration for  Services 
    # ------------------------------------------

    ./avahi
    ./bluetooth-manager
    ./dbus
    ./earlyoom
    ./envfs
    ./flat-pak
    ./fstrim
    ./mysql
    ./openssh
    ./openssh
    ./printer
    ./samba
    ./scanner
    ./sddm
    ./sshd
    ./udev
    ./udisks2
    ./update-firmware
    ./xdg-portal
    ./xserver

  ];
}
