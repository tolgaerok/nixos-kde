{ config, pkgs, ... }:

{
  # minidlna service
  #services.minidlna.enable = true;
  #services.minidlna.announceInterval = 60;
  #services.minidlna.friendlyName = "Tolgas-DLNA";
  #services.minidlna.mediaDirs = [ "PA,/home/tolga/public/Musique/" "PV,/home/tolga/public/Videos/" ];

  #DLNA
  services.minidlna.enable = true;
  services.minidlna.settings = {
    friendly_name = "NixOS-DLNA";
    media_dir = [
      "P,/home/tolga/public/Music/" # Videos files are located here
      "PV,/home/tolga/public/Vids/" # Audio files are here
      "PV,/mnt/sambashare/"
      "PV,/mnt/DLNA/"
    ];
    log_level = "error";
    inotify = "yes";
  };

  users.users.minidlna = {
    extraGroups =
      [ "users" "samba" "wheel" "tolga"]; # so minidlna can access the files.
  };

  # trick to create a directory with proper ownership
  # note that tmpfiles are not necesserarly temporary if you don't
  # set an expire time. Trick given on irc by someone I forgot the name..
  systemd.tmpfiles.rules = [ "d /home/tolga/public 0777 tolga users" ];
}

#     https://mylinuxramblings.wordpress.com/2016/02/19/mini-how-to-installing-minidlna-in-ubuntu/
#    "A" for audio    (eg. media_dir=A,/var/lib/minidlna/music)
#    "P" for pictures (eg. media_dir=P,/var/lib/minidlna/pictures)
#    "V" for video    (eg. media_dir=V,/var/lib/minidlna/videos)
#    "PV" for pictures and video (eg. media_dir=PV,/var/lib/minidlna/digital_camera)
