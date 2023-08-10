{ pkgs, ... }: 
{
  # Web Browsers:
  environment = {
    systemPackages = with pkgs; [
      firefox
      google-chrome
    ];
  };
}
