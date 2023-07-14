{ pkgs, ... }:

{

  # Allow Unfree Packages
  nixpkgs.config.allowUnfree = true;

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

  # Custom fonts - Chris Titus setup
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    font-awesome
    source-han-sans
  ];

  # Nix package collection (pkgs) that you want to include in the system environment.
  environment.systemPackages = with pkgs; [
    audacity
    asciiquarium
    asunder
    atool
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
    libsForQt5.kweather
    libsForQt5.kweathercore
    libopus
    libvorbis
    lsdvd
    lolcat
    lz4
    lzip
    lzo
    lzop
    ocamlPackages.gstreamer
    mariadb
    mosh
    mp3fs
    mpg123
    mplayer
    mpv
    ncdu
    neofetch
    neovim
    ntfs3g
    nix-direnv
    nixfmt
    nixos-option
    ookla-speedtest
    p7zip
    parallel-full
    pfetch
    pmutils
    powershell
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
    scanbd
    scala-cli
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
    video-trimmer
    vim
    vlc
    vscode
    vscode-with-extensions
    direnv
    vscode-extensions.mkhl.direnv
    nix-direnv
    wget
    whatsapp-for-linux
    wl-clipboard
    wpsoffice
    xdg-utils
    xdg-desktop-portal-gtk
    xdg-launch
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
