{ pkgs, ... }: {
  # Andriod:
  environment = {
    systemPackages = with pkgs; [

      # Andriod Utilities     
      # adbfs-rootless
      # android-studio
      # haskellPackages.adb
      android-file-transfer   # added by wvpianoman
      android-tools      
      droidcam                # added by wvpianoman
      scrcpy                  # added by wvpianoman
      waydroid                # added by wvpianoman
    ];
  };
}
