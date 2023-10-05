{ pkgs, ... }: {
  #---------------------------------------------------------------------
  # File Systems and Archiving:
  #---------------------------------------------------------------------

  environment = {
    systemPackages = with pkgs; [

      # Libraries
      libarchive
      libbtbb
      libnotify
    ];
  };
}
