{ pkgs, ... }:
{
  # Miscellaneous:
  environment = {
    systemPackages = with pkgs; [
      fish
      flatpak
      libsForQt5.kweather
      libsForQt5.kweathercore
      lolcat
    ];
  };
}
