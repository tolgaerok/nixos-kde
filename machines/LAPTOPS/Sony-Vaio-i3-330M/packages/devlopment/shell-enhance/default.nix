{ pkgs, ... }: {

  # Shell Enhancements and Utilities:
  
  environment = {
    systemPackages = with pkgs; [

      # Fonts and Shell
      rPackages.fontawesome
      zsh
      zsh-autosuggestions
      zsh-syntax-highlighting

    ];
  };
}
