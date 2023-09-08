{ pkgs, ... }: {

  # Theme systemPackages

  environment = {
    systemPackages = with pkgs; [ yaru-remix-theme catppuccin-kvantum ];
  };
}
