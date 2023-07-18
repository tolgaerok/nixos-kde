{ pkgs, ... }:
{
  # Media Management:
  environment = {
    systemPackages = with pkgs; [
      digikam      
    ];
  };
}
