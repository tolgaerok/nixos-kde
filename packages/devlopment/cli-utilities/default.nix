{ pkgs, ... }: {
  # Command Line Tools Utilities:

  environment = {
    systemPackages = with pkgs; [

      # Utilities
      # fastfetch
      bat
      cliphist
      dialog
      doas
      fx
      fzf
      vulkan-tools
      wayland-utils
      wl-clipboard

    ];
  };
}
