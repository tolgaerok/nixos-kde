{ pkgs, ... }: {
  # Command Line Tools Utilities:

  environment = {
    systemPackages = with pkgs; [

      # Utilities
      bat
      cliphist
      dialog
      fx
      fzf
      
    ];
  };
}
