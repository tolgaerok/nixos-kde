{ pkgs, ... }:

{
  #---------------------------------------------------------------------
  # Configure your nixpkgs instance
  #---------------------------------------------------------------------

  nixpkgs = {
    config = {
      # Allow Unfree Packages
      allowUnfree = true;
      # Accept the joypixels license
      joypixels.acceptLicense = true;
    };
  };

  #---------------------------------------------------------------------
  # Allow insecure or old pkgs - Help from nix package manager
  #---------------------------------------------------------------------

  nixpkgs.config.permittedInsecurePackages =
    [ "openssl-1.1.1u" "python-2.7.18.6" ];

  #---------------------------------------------------------------------
  # Define a set of programs and their respective configurations
  #---------------------------------------------------------------------

  programs = {
    # kdeconnect = { enable = true; };
    dconf = { enable = true; };
    mtr = { enable = true; };
  };

  #---------------------------------------------------------------------
  # Enables support for Flatpak - Flatpak website
  #---------------------------------------------------------------------

  services.flatpak.enable = true;

  #---------------------------------------------------------------------
  # Enables the D-Bus service, which is a message bus system that allows 
  # communicaflatpak-packages.nixtion between applications
  # Thanks Chris Titus!
  #---------------------------------------------------------------------

  services.dbus.enable = true;

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
        serif = [ "Source Serif" ];
        sansSerif = [ "Work Sans" "Fira Sans" "FiraGO" ];
        monospace = [ "FiraCode Nerd Font Mono" "SauceCodePro Nerd Font Mono" ];
        emoji = [ "Joypixels" "Noto Color Emoji" ];
      };
      enable = true;
      hinting = {
        autohint = false;
        enable = true;
        style = "hintslight";
      };
      subpixel = {
        rgba = "rgb";
        lcdfilter = "light";
      };
    };
  };

}
