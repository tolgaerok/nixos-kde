{ pkgs, ... }:
{
  # Shell Enhancements and Utilities:
  environment = {
    systemPackages = with pkgs; [
      zsh
      zsh-autosuggestions
      zsh-syntax-highlighting
    ];
  };
}
