{ pkgs, ... }:
{
  # Remote Access and Automation:
  environment = {
    systemPackages = with pkgs; [
      sshpass
      powershell
      heroku
    ];
  };
}
