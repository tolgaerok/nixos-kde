{ pkgs, ... }: {
  # Andriod:
  environment = {
    systemPackages = with pkgs; [

      # Andriod Utilities     
      # adbfs-rootless
      # haskellPackages.adb
      android-tools      
      android-file-transfer   # added by wvpianoman
      droidcam                # added by wvpianoman
      scrcpy                  # added by wvpianoman
      waydroid                # added by wvpianoman
    ];
  };
}
