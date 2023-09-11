{ pkgs, ... }: {

  # Theme systemPackages

  environment = {
    systemPackages = with pkgs; [
      #layan-gtk-theme
      #nordzy-cursor-theme
      #nordzy-icon-theme
      #tela-icon-theme
      #theme-jade1
     # arc-kde-theme
     # catppuccin-kvantum
     # layan-kde
     # qogir-theme

    ];
  };
}
