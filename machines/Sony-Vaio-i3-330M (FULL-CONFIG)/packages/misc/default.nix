{ pkgs, ... }:
{
  # Miscellaneous:
  environment = {
    systemPackages = with pkgs; [

      cowsay                  # fortune | cowsay -f tux   fortune | cowsay -e ^^    fortune | cowsay | lolcat
      fish
      flatpak
      fortune                 # unstr rot strfile fortune
      libsForQt5.kweather
      libsForQt5.kweathercore
      lolcat                  # "lolcat" for colorful output

    ];
  };
}
