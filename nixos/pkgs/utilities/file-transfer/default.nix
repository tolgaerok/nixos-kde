{ pkgs, ... }:
{
  # File Transfer:
  environment = {
    systemPackages = with pkgs; [
      transmission      
    ];
  };
}
