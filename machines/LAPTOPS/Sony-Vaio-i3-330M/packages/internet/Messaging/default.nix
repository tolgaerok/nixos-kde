{ pkgs, ... }:
{
  # Messaging and Communication:
  environment = {
    systemPackages = with pkgs; [
      discord
      whatsapp-for-linux
      zoom-us
    ];
  };
}
