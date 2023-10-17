{ pkgs, ... }: {
  # Network Testing and Monitoring:
  environment = {
    systemPackages = with pkgs; [

      # Network Utilities
      #doppler
      #ookla-speedtest
      
    ];
  };
}
