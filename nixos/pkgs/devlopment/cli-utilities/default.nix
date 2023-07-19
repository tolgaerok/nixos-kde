{pkgs, ...}: 
{
# Command Line Tools Utilities:
  environment = {
    systemPackages = with pkgs; [
      bat
      cliphist
      dialog
      fx
      fzf
    ];
  };
}
