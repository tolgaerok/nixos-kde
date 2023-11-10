{ pkgs, config, ... }:

# --------------------------------------------------------------
# Enabling SMART drive monitoring, installing smartmontools, 
# configuring Prometheus exporters, and setting firewall rules 
# for specific ports
# --------------------------------------------------------------

{
  environment.systemPackages = with pkgs; [ smartmontools ];

  # Terminal: sudo smartctl -a -d ata /dev/sda   or   sudo smartctl -a -d sat /dev/sda
  # View SMART Attributes:  sudo smartctl -a /dev/sda
  # Self test (Short):      sudo smartctl -t short /dev/sda
  # Self test results:      sudo smartctl -l selftest /dev/sda


  # SMART drive monitoring
  services.smartd = {
    enable = true;
    autodetect = true;
  };

  # SMART metrics exporter
  services.prometheus.exporters.smartctl = {
    enable = true;
    maxInterval = "20s";
  };

  # Firewall
  networking.firewall.interfaces."zt*".allowedTCPPorts =
    [ config.services.prometheus.exporters.smartctl.port ];
}
