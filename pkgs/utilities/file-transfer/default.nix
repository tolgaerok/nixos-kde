{ pkgs, ... }:
{
  # File Transfer:
  
  environment = {
    systemPackages = with pkgs; [
      filezilla
      libfilezilla
      rsync 
      transmission-gtk

    ];
  };
}
