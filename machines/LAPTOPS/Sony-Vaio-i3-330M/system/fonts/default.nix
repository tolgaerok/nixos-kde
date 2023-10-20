{ pkgs, ... }:

{

  #---------------------------------------------------------------------
  # Custom fonts - Chris Titus && wimpysworld
  #---------------------------------------------------------------------

  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      (nerdfonts.override {
        fonts = [ "FiraCode" "SourceCodePro" "UbuntuMono" ];
      })
      fira
      fira-go
      font-awesome
      hackgen-nf-font
      joypixels
      liberation_ttf
      line-awesome
      nerd-font-patcher
      nerdfonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      source-han-sans
      source-serif
      ubuntu_font_family
      work-sans
    ];

    #---------------------------------------------------------------------
    # Enable a basic set of fonts providing several font styles and 
    # families and reasonable coverage of Unicode.
    #---------------------------------------------------------------------

    enableDefaultFonts = false;

    fontconfig = {
      antialias = true;
      defaultFonts = {
        emoji = [ "Joypixels" "Noto Color Emoji" ];
        monospace = [ "FiraCode Nerd Font Mono" "SauceCodePro Nerd Font Mono" ];
        sansSerif = [ "Work Sans" "Fira Sans" "FiraGO" ];
        serif = [ "Source Serif" ];
      };
      enable = true;
      hinting = {
        autohint = false;
        enable = true;
        style = "hintslight";
      };
      subpixel = {
        lcdfilter = "light";
        rgba = "rgb";
      };
    };
  };

}
