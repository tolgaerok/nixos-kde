{ pkgs, ... }: {

  # XSCREENSAVER [ xscreensaver-command xscreensaver-demo xscreensaver xscreensaver-settings ]

  environment = {
    systemPackages = with pkgs;
      [

        # xscreensaver
        xscreensaver

      ];
  };
}
