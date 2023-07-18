{ pkgs, ... }:
{
  # Messaging and Communication:
  environment = {
    systemPackages = with pkgs; [
      whatsapp-for-linux
    ];
  };
}
