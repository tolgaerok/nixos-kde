{ pkgs, ... }:

{
  #---------------------------------------------------------------------
  # Configure your nixpkgs instance
  #---------------------------------------------------------------------

  nixpkgs = {
    config = {
      # Allow Unfree Packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
      # Accept the joypixels license
      joypixels.acceptLicense = true;
    };
  };

  #---------------------------------------------------------------------
  # Allow insecure or old pkgs - Help from nix package manager
  #---------------------------------------------------------------------

  nixpkgs.config.permittedInsecurePackages =
    [ "openssl-1.1.1v" "python-2.7.18.6" ];

  # "openssl-1.1.1u"

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
