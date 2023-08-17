{ pkgs, ... }:
{
  #---------------------------------------------------------------------
  # Office and Productivity:
  #---------------------------------------------------------------------

  environment = {
    systemPackages = with pkgs; [

      # Office suite
      wpsoffice     

      # Desktop accessories
      deepin.deepin-calculator
      
    ];
  };
}
