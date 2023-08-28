{ pkgs, ... }: {
  # Andriod:
  environment = {
    systemPackages = with pkgs; [

      # Andriod Utilities     
      # adbfs-rootless
      # haskellPackages.adb
      android-tools
      android-file-transfer
      droidcam
      scrcpy
      waydroid
      
    ];
  };
}
