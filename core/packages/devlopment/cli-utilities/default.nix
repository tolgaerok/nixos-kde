{ pkgs, ... }: {
  # Command Line Tools Utilities:

  environment = {
    systemPackages = with pkgs; [

      # Utilities
      # bat
      # cliphist
      # fastfetch
      # wayland-utils
      dialog
      doas
      fx
      fzf
      

    ];
  };
}
