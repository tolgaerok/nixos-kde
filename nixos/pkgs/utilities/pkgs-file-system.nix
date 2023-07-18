{ pkgs, ... }:
{
  # File Systems and Archiving:
  environment = {
    systemPackages = with pkgs; [
      libarchive
      libbtbb
    ];
  };
}
