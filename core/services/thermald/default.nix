{ ... }:

{
  services = {
    thermald = {

      enable = false;
    };
  };
}

# thermald is a Linux daemon that helps manage the thermal environment 
# of a system. It's designed to work on devices like 
# laptops, desktops, and even servers – any system running 
# a Linux distribution with the appropriate thermal management support.
