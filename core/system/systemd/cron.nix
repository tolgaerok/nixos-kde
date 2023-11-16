{ config, pkgs, ... }:

let
  nixosArchive = pkgs.writeScriptBin "nixos-archive" ''
    #!/bin/sh
    nixos-archive
  '';

  nixosCheckUpdates = pkgs.writeScriptBin "nixos-check-updates" ''
    #!/bin/sh
    nixos-check-updates
  '';

in {
  security.sudo.extraConfig = ''
    username ALL=(ALL) NOPASSWD: $PATH/nixos-check-updates
  '';

  systemd.services.nixos-archive = {
    serviceConfig.Type = "oneshot";
    path = with pkgs; [ nixosArchive ];
    script = ''
      #!/bin/sh
      sudo nixos-archive
    '';
  };

  systemd.timers.nixos-archive = {
    wantedBy = [ "timers.target" ];
    partOf = [ "nixos-archive.service" ];
    timerConfig = {
      # every 59 minutes
      OnCalendar = "*/59 * * * *";
      Unit = "nixos-archive.service";
    };
  };

  systemd.services.nixos-check-updates = {
    serviceConfig.Type = "oneshot";
    path = with pkgs; [ nixosCheckUpdates ];
    script = ''
      #!/bin/sh
      sudo nixos-check-updates
    '';
  };

  systemd.timers.nixos-check-updates = {
    wantedBy = [ "timers.target" ];
    partOf = [ "nixos-check-updates.service" ];
    timerConfig = {
      # every 5 minutes
      OnCalendar = "*/5 * * * *";
      Unit = "nixos-check-updates.service";
    };
  };

  #---------------------------------------------------------------------
  # Back up nixos folder every 59 min 
  #---------------------------------------------------------------------
  services.cron = {
    enable = true;
    systemCronJobs = [
      "*/59 * * * * nixos-archive >> /home/tolga/test.log"
      "*/5 * * * * nixos-check-updates >> /home/tolga/test.log"
    ];
  };
}
