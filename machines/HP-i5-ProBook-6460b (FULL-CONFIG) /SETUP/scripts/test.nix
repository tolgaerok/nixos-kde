{ config, ... }:

let
  script = ''
    #!/bin/sh
    echo "Detected RAM: $DETECTED_RAM MB"
  '';

in
{
  systemd.services.detect-ram = {
    description = "Script to detect RAM";
    serviceConfig.Type = "oneshot";
    serviceConfig.Environment = {
      DETECTED_RAM = ''
        $(free -m | awk '/^Mem/ {print $2}')
      '';
    };
    serviceConfig.ExecStart = "/bin/sh -c \"$script\"";
    wantedBy = [ "multi-user.target" ];
  };
}
