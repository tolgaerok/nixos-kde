{ config, lib, pkgs, modulesPath, ... }:

  #---------------------------------------------------------------------
  # Personal samba-share && mount point
  #---------------------------------------------------------------------

{ 

  fileSystems."/mnt/WindowsServer" = {
    device = "//192.168.0.20/";
    fsType = "cifs";
    options = let
      automountOpts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,x-systemd.requires=network.target";

      # Replace with your actual user ID, use `id -u <YOUR USERNAME>` to get your user ID  
      uid = "1000"; 
      # Replace with your actual group ID, use `id -g <YOUR USERNAME>` to get your group ID
      gid = "100"; 

      vers = "3.1.1";
      cacheOpts = "cache=loose";
      credentialsPath = "/etc/nixos/core/system/network/smb-secrets";
    in [
      "${automountOpts},credentials=${credentialsPath},uid=${uid},gid=${gid},rw,vers=${vers},${cacheOpts}"
    ];

  };

  fileSystems."/mnt/LinuxData" = {
    device = "//192.168.0.20/LinuxData/";
    fsType = "cifs";
    options = let
      automountOpts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,x-systemd.requires=network.target";

      # Replace with your actual user ID, use `id -u <YOUR USERNAME>` to get your user ID  
      uid = "1000"; 
      # Replace with your actual group ID, use `id -g <YOUR USERNAME>` to get your group ID
      gid = "100"; 

      vers = "3.1.1";
      cacheOpts = "cache=loose";
      credentialsPath = "/etc/nixos/core/system/network/smb-secrets";
    in [ 
      "${automountOpts},credentials=${credentialsPath},uid=${uid},gid=${gid},rw,vers=${vers},${cacheOpts}"
    ];

  };

  fileSystems."/mnt/WindowsData" = {
    device = "//192.168.0.20/WINDOWSDATA/";
    fsType = "cifs";
    options = let
      automountOpts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s,x-systemd.requires=network.target";

      # Replace with your actual user ID, use `id -u <YOUR USERNAME>` to get your user ID  
      uid = "1000"; 
      # Replace with your actual group ID, use `id -g <YOUR USERNAME>` to get your group ID
      gid = "100"; 

      vers = "3.1.1";
      cacheOpts = "cache=loose";
      credentialsPath = "/etc/nixos/core/system/network/smb-secrets";
    in [
      "${automountOpts},credentials=${credentialsPath},uid=${uid},gid=${gid},rw,vers=${vers},${cacheOpts}"
    ];

  };

  fileSystems."/mnt/MyGitHubProjects" = {
    device = "/home/tolga/MyGitHubProjects/";
    fsType = "none";
    options = [ "rw" "bind" ];
  };

  fileSystems."/mnt/DLNA" = {
    device = "/home/tolga/DLNA";    
    fsType = "none";
    options = [ "rw" "bind" ];
    # http://192.168.0.13:8200/
  };

}
