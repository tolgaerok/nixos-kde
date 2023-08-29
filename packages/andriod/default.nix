{ pkgs, ... }: {
  # Andriod:
  environment = {
    systemPackages = with pkgs; [

      # Andriod Utilities     
      # adbfs-rootless
      # haskellPackages.adb
      android-tools
      android-file-transfer
      android-tools
      droidcam
      scrcpy
      waydroid

    ];
  };
}
