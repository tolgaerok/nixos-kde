{ pkgs, ... }: {
  # Andriod:
  environment = {
    systemPackages = with pkgs; [

      # Andriod Utilities     
      # adbfs-rootless
      # haskellPackages.adb
      android-tools
<<<<<<< HEAD
      android-file-transfer
      android-tools
      droidcam
      scrcpy
      waydroid

=======
      android-file-transfer   # added by wvpianoman
      droidcam                # added by wvpianoman
      scrcpy                  # added by wvpianoman
      waydroid                # added by wvpianoman
      
>>>>>>> 961fa1279141f9f772604096a57956ac994c4c27
    ];
  };
}
