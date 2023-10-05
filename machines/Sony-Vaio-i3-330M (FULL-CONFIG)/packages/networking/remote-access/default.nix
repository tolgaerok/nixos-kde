{ config, lib, pkgs, ... }:
{
  # Remote Access and Automation:
  
  imports =
  [
   # ./teamviewer.nix
  ];

  environment = {
    systemPackages = with pkgs; [
      # Remote Access & Deployment
      #heroku
      #openssh
      #powershell
      #sshpass
      teamviewer 
      zoom-us
      # nomachine-client
    ];
  };

  services.teamviewer.enable = true;
}
