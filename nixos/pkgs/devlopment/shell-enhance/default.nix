{ pkgs, ... }:
{
  # Shell Enhancements and Utilities:
  environment = {
    systemPackages = with pkgs; [
      rPackages.fontawesome
      zsh
      zsh-autosuggestions
      zsh-syntax-highlighting
    ];
  };
}
