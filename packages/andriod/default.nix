{ pkgs, ... }: {
  # Andriod:
  environment = {
    systemPackages = with pkgs; [

      # Andriod Utilities     
      adbfs-rootless
      android-tools
      haskellPackages.adb
      
    ];
  };
}
