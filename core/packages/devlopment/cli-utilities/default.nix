{ pkgs, ... }: {
  # Command Line Tools Utilities:

  environment = {
    systemPackages = with pkgs; [

      # Utilities
      # bat
      # cliphist
      # fastfetch
      dialog
      doas
      fx
      fzf
      wayland-utils
      wl-clipboard

    ];
  };
}
