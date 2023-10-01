{ pkgs, ... }:
{
  # Clipboard Utilities:
  environment = {
    systemPackages = with pkgs; [
      wl-clipboard      
    ];
  };
}
