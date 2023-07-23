{ pkgs, ... }:
{
  # Network Testing and Monitoring:
  environment = {
    systemPackages = with pkgs; [
      doppler
      ookla-speedtest
    ];
  };
}
