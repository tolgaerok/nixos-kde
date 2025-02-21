{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;


 # fileSystems."/mnt/share" = {
 #   device = "/dev/sda"; # Replace 'sdX' with the actual device name
 #   fsType = "ext4"; # Replace with the desired file system type
  #  options = ["credentials=/etc/nixos/smb-secrets,uid=1000,gid=100"];
    # or if you have specified `uid` and `gid` explicitly through NixOS configuration,
    # you can refer to them rather than hard-coding the values:
    # options = ["credentials=/etc/nixos/smb-secrets,uid=${config.users.users.<username>.uid},gid=${config.users.groups.<group>.gid}"];
 # };

  networking = {
    enableIPv6 = false;
    #firewall.enable = false;
    firewall.allowPing = true;
    hostName = "NixOs";
    networkmanager.enable = true;
  };

  # Set your time zone.
  time.timeZone = "Australia/Perth";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_AU.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_AU.UTF-8";
    LC_IDENTIFICATION = "en_AU.UTF-8";
    LC_MEASUREMENT = "en_AU.UTF-8";
    LC_MONETARY = "en_AU.UTF-8";
    LC_NAME = "en_AU.UTF-8";
    LC_NUMERIC = "en_AU.UTF-8";
    LC_PAPER = "en_AU.UTF-8";
    LC_TELEPHONE = "en_AU.UTF-8";
    LC_TIME = "en_AU.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "au";
    xkbVariant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tolga = {
    isNormalUser = true;
    description = "tolga erok";
    extraGroups = [ "networkmanager" "wheel" ];

    packages = with pkgs; [
      firefox
      kate
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Disable warnings, auto store optimization and enable experimental features
  nix = {
    settings = {
      warn-dirty = false;
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes" "repl-flake"];
    };

    # Enable automatic garbage collection, frequency of garbage collection and deleting older generations older-than 3d
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 3d";
    };
  };

  # Add 'openssl-1.1.1u' to permitted insecure packages.
  nixpkgs.config.permittedInsecurePackages = [
    "openssl-1.1.1u"
  ];

  # List packages installed in system profile. To search, run: nix search wget
  environment.systemPackages = with pkgs; [
    # Failed
    # bluezUtilities
    asciiquarium
    bat
    blueberry
    blueman
    bluez
    bluez-tools
    bluez5-experimental
    bottom
    btop
    cachix
    caprine-bin
    cifs-utils
    cliphist
    cmatrix
    coursier
    cowsay
    delta
    direnv
    doppler
    duf
    fd
    figlet
    fx
    fzf
    gh
    gimp-with-plugins
    git
    glow
    gnome.simple-scan
    google-chrome
    gparted
    graalvm17-ce
    graphviz
    gum
    heroku
    htop
    imagemagick
    ipfetch
    kate
    keychain
    kitty
    kitty-themes
    krita
    less
    libbtbb
    lolcat
    mosh
    mpv
    ncdu
    neofetch
    neovim
    nix-direnv
    nomachine-client
    ookla-speedtest
    p7zip
    powershell
    pulumi
    python311Full
    ripgrep
    ripgrep-all
    samba
    scala-cli
    sl
    sshpass
    stow
    sublime4
    tig
    tldr
    tree
    unzip
    vim
    vlc
    wget
    whatsapp-for-linux
    wl-clipboard
    wpsoffice
    xfce.thunar
    youtube-dl
    zsh
  ];

  # Fonts
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    font-awesome
    source-han-sans
    source-han-sans-japanese
    source-han-serif-japanese
  ];

  # List services and or custom Hardware additions:

  #* Enable Bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  #* Enable Flatpak
  services.flatpak.enable = true;

  #* Nvidia
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  hardware.nvidia.modesetting.enable = true;

  #* Add scanner drivers (Epson)
  hardware.sane.enable = true;
  hardware.sane.extraBackends = [ pkgs.epkowa ];
  #services.udev.packages = [ pkgs.utsushi ];

  #* Printer Drivers
  services.printing.drivers = [ pkgs.gutenprint ];
  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  services.avahi.openFirewall = true;

  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.copySystemConfiguration = true;
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
  system.stateVersion = "23.05"; # Did you read the comment?

  services.samba-wsdd.enable = true; # make shares visible for windows 10 clients

  networking.firewall.extraCommands = ''iptables -t raw -A OUTPUT -p udp -m udp --dport 137 -j CT --helper netbios-ns'';

  services.samba = {
    enable = true;
    package = pkgs.sambaFull;
    openFirewall = true; # Automatically open firewall ports
    securityType = "user";
    extraConfig = ''
      workgroup = WORKGROUP
      server string = smb-NixOs23
      netbios name = smb-NixOs23
      security = user 
      #use sendfile = yes
      #max protocol = smb2
      # note: localhost is the ipv6 localhost ::1
      hosts allow = 192.168.0. 127.0.0.1 localhost
      hosts deny = 0.0.0.0/0
      guest account = nobody
      map to guest = bad user
      load printers = yes
      printing = cups
      printcap name = cups
    '';
    shares = {
      NixOs23-KDE-Public  = {
        path = "/home/tolga/Public";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "yes";
        "writable" = "yes";
        "create mask" = "0777";
        "directory mask" = "0777";
        "force user" = "tolga";
        "force group" = "samba";
      };
      NixOs23-KDE-Private = {
        path = "/home/NixOs-KDE";
        browseable = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "tolga";
        "force group" = "samba";
      };
      printers = {
        comment = "All Printers";
        path = "/var/spool/samba";
        public = "yes";
        browseable = "yes";
        # to allow user 'guest account' to print.
        "guest ok" = "yes";
        writable = "no";
        printable = "yes";
        "create mode" = 0700;
      };
    };
  };

  systemd.tmpfiles.rules = [
    "d /var/spool/samba 1777 root root -"
  ];
}
