{ config, hostname, pkgs, username, lib, ... }:

#--------------------------------------------------------------------- 
# Configuration for networking and samba
#--------------------------------------------------------------------- 

{

  imports = [

    ./samba

  ];

  #--------------------------------------------------------------------- 
  # Modify autoconnect priority of the connection
  #--------------------------------------------------------------------- 


  #--------------------------------------------------------------------- 
  # Enable openssh
  #--------------------------------------------------------------------- 

  services = { openssh = { enable = true; }; };

}