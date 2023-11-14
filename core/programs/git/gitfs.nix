# /etc/nixos/gitfs.nix

{ config, lib, pkgs, ... }:

{
  config = {
    services.gitfs = {
      enable = true;

      configFile = "/etc/nixos/core/programs/git/gitfs.conf";
      mountPoint = "/mnt/gitfs";

      systemd.services.gitfs = {
        description = "Gitfs service";
        after = [ "network.target" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          ExecStart = "${pkgs.gitfs}/bin/gitfs -c ${config.services.gitfs.configFile} ${config.services.gitfs.mountPoint}";
          ExecStop = "${pkgs.gitfs}/bin/fusermount -u ${config.services.gitfs.mountPoint}";
          Restart = "always";
          RestartSec = "3";
        };
      };
    };

    environment.systemPackages = with pkgs; [
      gcc
      (pkgs.python39.withPackages (ps: [ ps.gitfs ]))
      python39Packages.virtualenv # or use python3 if it corresponds to Python 3.9
    ];
  };
}
