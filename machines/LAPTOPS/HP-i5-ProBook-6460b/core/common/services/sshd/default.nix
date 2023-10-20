{ config, lib, ... }:

{

  #--------------------------------------------------------------------- 
  #   SSH daemon (sshd) service, allowing secure remote access to the 
  #   system via SSH.
  #--------------------------------------------------------------------- 
  services.sshd.enable = true;

}
