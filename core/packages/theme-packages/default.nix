{ pkgs, ... }: {

  # Theme systemPackages

  environment = {
    systemPackages = with pkgs; [
      #layan-gtk-theme
      #layan-kde
      #nordzy-cursor-theme
      #nordzy-icon-theme
      #qogir-theme
      #tela-icon-theme
      #theme-jade1
      # arc-kde-theme
      catppuccin-kvantum
      papirus-folders
      papirus-icon-theme
      yaru-remix-theme
      yaru-theme
    ];
  };
}
