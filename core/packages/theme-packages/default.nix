{ pkgs, ... }: {

  # Theme systemPackages

  environment = {
    systemPackages = with pkgs;
      [
        # arc-kde-theme
        # catppuccin-kvantum
        # layan-gtk-theme
        # layan-kde
        # nordzy-cursor-theme
        # nordzy-icon-theme
        # qogir-theme
        # tela-icon-theme
        # theme-jade1

      ];
  };
}
