{ config, pkgs, lib, ... }:

let cfg = config.iphone;

in {
  options.iphone = {

    enable = lib.mkOption { default = false; };
    directory = lib.mkOption { default = "/tmp/iPhone"; };
    user = lib.mkOption { };

  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [

      pkgs.libimobiledevice
      pkgs.usbmuxd
      (pkgs.writeScriptBin "iphone" ''
        echo "restarting iphone service" && \
        echo "if does not work, restart or kill-start usbmuxd service" && \
        sudo systemctl restart iphone \
          && ${pkgs.xdg_utils}/bin/xdg-open ${cfg.directory}
      '')
    ];

    services.usbmuxd.enable = true;
    services.usbmuxd.user = cfg.user;

    systemd.services.iphone = {

      preStart =
        "mkdir -p ${cfg.directory}; chown ${cfg.user} ${cfg.directory}";
      script = ''
        ${pkgs.libimobiledevice}/bin/idevicepair pair \
        && exec ${pkgs.ifuse}/bin/ifuse ${cfg.directory}
      '';

      serviceConfig = {

        PermissionsStartOnly = true;
        User = cfg.user;
        Type = "forking";
      };

    };
  };

}
