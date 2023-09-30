{ pkgs, ... }:
{
  
  environment = {
    systemPackages = with pkgs; [

      # Media and Entertainment:
      vlc
      youtube-dl
    ];
  };
}
