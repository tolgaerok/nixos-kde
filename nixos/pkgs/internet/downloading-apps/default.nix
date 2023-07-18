{pkgs, ...}: 
{
  # Downloading and Retrieving Files:
  environment = {
    systemPackages = with pkgs; [
     clipgrab
     wget
    ];
  };
}
