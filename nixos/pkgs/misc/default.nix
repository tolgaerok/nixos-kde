{ pkgs, ... }:
{
  # Miscellaneous:
  environment = {
    systemPackages = with pkgs; [
      libsForQt5.kweather
      libsForQt5.kweathercore
      lolcat
      fish
      flatpak
    ];
  };
}
