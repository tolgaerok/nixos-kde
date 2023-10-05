{ pkgs, ... }:
{
  
  
  environment = {
    systemPackages = with pkgs; [

      # File Transfer:
      filezilla
      libfilezilla
      rsync 
      transmission-gtk

    ];
  };
}
