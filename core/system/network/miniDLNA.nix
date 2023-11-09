{ config, pkgs, ... }:

{
  # DLNA service: Check if working. Open browser: http://192.168.0.13:8200/
  # Add: ports 8200
  # ------------------------------------------------------------------------
  services.minidlna.enable = true;
  services.minidlna.settings = {
    friendly_name = "NixOS-DLNA";

    #     https://mylinuxramblings.wordpress.com/2016/02/19/mini-how-to-installing-minidlna-in-ubuntu/
    #    "A" for audio    (eg. media_dir=A,/var/lib/minidlna/music)
    #    "P" for pictures (eg. media_dir=P,/var/lib/minidlna/pictures)
    #    "V" for video    (eg. media_dir=V,/var/lib/minidlna/videos)
    #    "PV" for pictures and video (eg. media_dir=PV,/var/lib/minidlna/digital_camera)

    media_dir = [
      "PV,/home/tolga/public/Music/" # Music files are located here
      "PV,/home/tolga/public/Vids/" # Audio files are here
      "PV,/mnt/sambashare/DLNA/"
      #"PV,/mnt/DLNA/"
    ];

  
    inotify = "yes";
    log_level = "error";
    announceInterval = 05;
  };

  users.users.minidlna = {
    extraGroups =
      [ "users" "samba" "wheel" "tolga" ]; # so minidlna can access the files.
  };

  networking.firewall = {
    enable = false;
    allowedTCPPorts = [ 8200 ];
    allowedUDPPorts = [ 8200 ];
  };

}

