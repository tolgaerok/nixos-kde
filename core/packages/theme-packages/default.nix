{ pkgs, ... }: {

  # Theme systemPackages

  environment = {
    systemPackages = with pkgs; [
      catppuccin-kvantum
      layan-gtk-theme
      layan-kde
      nordzy-cursor-theme
      nordzy-icon-theme
      papirus-folders
      papirus-icon-theme
      qogir-theme
      tela-icon-theme
      theme-jade1
      yaru-remix-theme
      yaru-theme
    ];
  };
}
