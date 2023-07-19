{pkgs, ...}: 
{
# Image Scanning and Processing:
  environment = {
    systemPackages = with pkgs; [
      sane-backends
      scanbd
    ];
  };
}
