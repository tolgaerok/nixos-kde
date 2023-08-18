{ pkgs, ... }:
{
  # Media and Entertainment:
  environment = {
    systemPackages = with pkgs; [
      vlc
      youtube-dl
    ];
  };
}
