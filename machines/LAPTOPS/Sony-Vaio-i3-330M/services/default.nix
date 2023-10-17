{ ... }: {

  imports = [

    # Configuration for  Services 

    # ./power-profiles-daemon   # Uncomment for laptops
    # ./thermald                # Uncomment for laptops
    # ./tlp                     # Uncomment for laptops
    ./bluetooth-manager
    ./dbus
    ./envfs
    ./flat-pak
    ./fstrim
    # ./mysql
    ./printer
    ./scanner
    ./udev
    ./udisks2
    ./xdg-portal
    ./xserver
    
  ];
}
