{ pkgs, ... }:
{
  # Code Search and Analysis:
  environment = {
    systemPackages = with pkgs; [
      ripgrep
      ripgrep-all
    ];
  };
}
