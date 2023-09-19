{ pkgs, ... }: {
  # Andriod:
  environment = {
    systemPackages = with pkgs; [

      # Andriod Utilities     
      # adbfs-rootless
      # android-studio
      # droidcam                # added by wvpianoman
      # haskellPackages.adb
      # scrcpy                  # added by wvpianoman
      # waydroid                # added by wvpianoman
      android-file-transfer   # added by wvpianoman
      android-tools      
      
    ];
  };
}
