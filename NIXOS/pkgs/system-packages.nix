{ pkgs, ... }:

{

  # Configure your nixpkgs instance
  nixpkgs = {
    config = {
      # Allow Unfree Packages
      allowUnfree = true;
      # Accept the joypixels license
      joypixels.acceptLicense = true;
    };
  };

  # Allow insecure or old pkgs - Help from nix package manager
  nixpkgs.config.permittedInsecurePackages =
    [ "openssl-1.1.1u" "python-2.7.18.6" ];

  # Define a set of programs and their respective configurations
  programs = {
    kdeconnect = { enable = true; };
    dconf = { enable = true; };
    mtr = { enable = true; };
  };

  # Enables support for Flatpak - Flatpak website
  services.flatpak.enable = true;

  # Enables the D-Bus service, which is a message bus system that allows communicaflatpak-packages.nixtion between applications
  # Thanks Chris Titus!
  services.dbus.enable = true;

  # Custom fonts - Chris Titus && wimpysworld
  fonts = {
    fontDir.enable = true;
    fonts = with pkgs; [
      (nerdfonts.override {
        fonts = [ "FiraCode" "SourceCodePro" "UbuntuMono" ];
      })
      fira
      fira-go
      font-awesome
      joypixels
      liberation_ttf
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      source-han-sans
      source-serif
      ubuntu_font_family
      work-sans
    ];

    # Enable a basic set of fonts providing several font styles and families and reasonable coverage of Unicode.
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

  # Nix package collection (pkgs) that you want to include in the system environment.
  environment.systemPackages = with pkgs; [
    asciiquarium
    asunder
    atool
    audacity
    bashInteractive
    bat
    blueberry
    brasero
    cifs-utils
    clipgrab
    cliphist
    cmatrix
    coursier
    cowsay
    delta
    dialog
    digikam
    direnv
    doppler
    duf
    fd
    ffmpeg
    ffmpegthumbnailer
    figlet
    firefox
    fish
    flatpak
    fx
    fzf
    gh
    gimp-with-plugins
    git
    git-extras
    glow
    gnome.simple-scan
    google-chrome
    gparted
    graalvm17-ce
    graphviz
    gum
    gzip
    heroku
    htop
    imagemagick
    ipfetch
    isoimagewriter
    kate
    kcalc
    keychain
    kitty
    kitty-themes
    kphotoalbum
    krename
    krita
    krusader
    lame
    less
    libarchive
    libbtbb
    libdvdcss
    libdvdread
    libopus
    libsForQt5.kweather
    libsForQt5.kweathercore
    libvorbis
    lolcat
    lsdvd
    lz4
    lzip
    lzo
    lzop
    mariadb
    mosh
    mp3fs
    mpg123
    mplayer
    mpv
    ncdu
    neofetch
    neovim
    nix-direnv
    nixfmt
    nixos-option
    ntfs3g
    ocamlPackages.gstreamer
    ookla-speedtest
    p7zip
    parallel-full
    pciutils
    pfetch
    pmutils
    powershell
    psmisc
    pulseaudioFull
    pulumi
    python.pkgs.pip
    python311Full
    rar
    ripgrep
    ripgrep-all
    rzip
    samba
    sane-backends
    scala-cli
    scanbd
    shotwell
    simplescreenrecorder
    sl
    sshpass
    stow
    sublime4
    tig
    tldr
    transmission
    tree
    unzip
    usbutils
    video-trimmer
    vim
    vlc
    vscode
    vscode-extensions.mkhl.direnv
    vscode-with-extensions
    wget
    whatsapp-for-linux
    wl-clipboard
    wpsoffice
    xdg-desktop-portal-gtk
    xdg-launch
    xdg-utils
    xfce.thunar
    xz
    youtube-dl
    zip
    zsh
    zsh-autosuggestions
    zsh-syntax-highlighting
    zstd
  ];

}
