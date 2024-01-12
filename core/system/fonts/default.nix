{ pkgs, ... }:

{

  #---------------------------------------------------------------------
  # Custom fonts - Chris Titus && wimpysworld
  #---------------------------------------------------------------------

  fonts = {
    fontDir.enable = true;
    fontconfig.enable = true;
    enableGhostscriptFonts = true;

    # fonts = with pkgs; [
    packages = with pkgs; [
      (nerdfonts.override {

        fonts = [

          "Agave"
          "FiraCode"
          "Inconsolata"
          "JetBrainsMono"
          "LiberationMono"
          "Overpass"
          "SourceCodePro"
          "Ubuntu"
          "UbuntuMono"

        ];
      })

      # (nerdfonts.override {fonts = ["Iosevka" "JetBrainsMono"];})
      # gg-sans

      comfortaa
      comic-neue
      corefonts
      dejavu_fonts
      fira
      fira-code
      fira-go
      font-awesome
      hackgen-nf-font
      inconsolata
      inter
      iosevka-bin
      jetbrains-mono
      jost
      joypixels
      lato
      lexend
      liberation_ttf
      line-awesome
      material-design-icons
      material-icons
      nerd-font-patcher
      nerdfonts
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      roboto
      source-han-sans
      source-sans
      source-serif
      twemoji-color-font
      ubuntu_font_family
      work-sans

    ];

    #---------------------------------------------------------------------
    # Enable a basic set of fonts providing several font styles and 
    # families and reasonable coverage of Unicode.
    #---------------------------------------------------------------------

    enableDefaultPackages = false;

    fontconfig = {
      allowBitmaps = true;
      antialias = true;
      cache32Bit = true;
      useEmbeddedBitmaps = true;

      defaultFonts = {
        emoji = [ "Joypixels" "Noto Color Emoji" ];
        monospace = [ "FiraCode Nerd Font Mono" "SauceCodePro Nerd Font Mono" ];
        sansSerif = [ "Work Sans" "Fira Sans" "FiraGO" ];
        serif = [ "Source Serif" ];
      };

      hinting = {
        autohint = false;
        enable = true;
        style = "slight";
      };

      subpixel = {
        lcdfilter = "light";
        rgba = "rgb";
      };

    };
  };

}
