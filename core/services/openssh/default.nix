{ config, pkgs, lib, ... }:
with lib;

{

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = lib.mkForce "yes";
      UseDns = false;
      X11Forwarding = false;
      PasswordAuthentication = lib.mkForce true;
      KbdInteractiveAuthentication = true;
    };

    banner = ''
      ⣿⣿⣿⣿⣿⣿⣿⣿⡿⠿⠛⠛⠛⠋⠉⠈⠉⠉⠉⠉⠛⠻⢿⣿⣿⣿⣿⣿⣿⣿
      ⣿⣿⣿⣿⣿⡿⠋⠁   Tolga Erok ⠀⠀⠀⠀⠛⢿⣿⣿⣿⣿
      ⣿⣿⣿⣧⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ⠀⣰⣿⣿⣿
      ⣿⣿⣿⣿⡄⠈⠀⠀⠀ ¯\_(ツ)_/¯⠀  ⢀⣠⣴⣾⣿⣿⣿⣿⣿
      ⣿⣿⣿⣿⣧⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿
      ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
      ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿
      ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿      
      >ligma


    '';

    hostKeys = [
      {
        bits = 4096;
        path = "/etc/ssh/ssh_host_rsa_key";
        type = "rsa";
      }

      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };

  programs.ssh.startAgent = true;
  networking.firewall.allowedTCPPorts = [ 22 ];

}
