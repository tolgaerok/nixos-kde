{ config, pkgs, lib, ... }:

let name = "tolga";

in {
  imports = [
    ./hardware/hardware-configuration.nix
    ./hardware/hardware-acceleration.nix
    ./pkgs/system-packages.nix
    #./pkgs/flatpak-packages.nix
  ];

  # Bootloader and System Settings
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # Activate the automatic trimming process for SSDs on the NixOS system  <=== Manual over-ride is sudo sudo fstrim / -v
  services.fstrim.enable = true;

  # Networking
  networking = {
    enableIPv6 = false;
    firewall.enable = false;
    firewall.allowPing = true;
    hostName = "NixOs";
    networkmanager.enable = true;
  };

  # Time Zone and Locale
  time.timeZone = "Australia/Perth";
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

  # X11 and KDE Plasma
  services.xserver.enable = true;
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.layout = "au";
  services.xserver.xkbVariant = "";

  # Audio
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # User Configuration
  users.users.tolga = {
    isNormalUser = true;
    description = "tolga erok";
    extraGroups = [ "networkmanager" "wheel" "input" "disk" "video" "audio" ];
    packages = with pkgs; [ ];
  };

  # Nix-specific settings and garbage collection options - Mostly research from NixOS wiki
  nix = {
    settings = {
      allowed-users = [ "@wheel" ];
      auto-optimise-store = true;
      sandbox = true;
      trusted-users = [ "root" "${name}" ];
      warn-dirty = false;
      # enable experimental features (needed for flakes)
      #package = pkgs.nixFlakes;
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
    };

    # Automatically trigger garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--max-freed 1G --delete-older-than 7d";
    };
  };

  # Provide a graphical Bluetooth manager for desktop environments
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # Nvidia drivers - NixOS wiki and help from David Turcotte (https://davidturcotte.com)
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.opengl.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  hardware.nvidia.modesetting.enable = true;

  # Scanner drivers
  hardware.sane.enable = true;
  hardware.sane.extraBackends = [ pkgs.epkowa ];

  # Printers and printer drivers (To suit my HP LaserJet 600 M601)
  # In terminal: sudo NIXPKGS_ALLOW_UNFREE=1 nix-shell -p hplipWithPlugin --run 'sudo -E hp-setup'
  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  services.avahi.openFirewall = true;
  services.printing.drivers =
    [ pkgs.gutenprint pkgs.hplip pkgs.hplipWithPlugin ];

  # System daemon for managing storage devices such as disks and USB drives
  services.udisks2.enable = true;

  # Enable the copying of system configuration files to the Nix store
  # Automatic system upgrades, automatically reboot after an upgrade if necessary
  system.copySystemConfiguration = true;
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
  system.stateVersion = "23.05";

  # Adding a rule to the iptables firewall to allow NetBIOS name resolution traffic on UDP port 137 - NixOS wiki
  services.samba-wsdd.enable = true;

  # Adding a rule to the iptables firewall to allow NetBIOS name resolution traffic on UDP port 137
  networking.firewall.extraCommands =
    "iptables -t raw -A OUTPUT -p udp -m udp --dport 137 -j CT --helper netbios-ns";

  # Samba Configuration - NixOS wiki
  # For a user to be authenticated on the samba server, you must add their password using sudo smbpasswd -a <user> as root
  services.samba = {
    enable = true;
    package = pkgs.sambaFull;
    openFirewall = true;
    securityType = "user";
    extraConfig = ''
      workgroup = WORKGROUP
      server string = smb-NixOs23
      netbios name = smb-NixOs23
      security = user
      hosts allow = 192.168.0. 127.0.0.1 localhost
      hosts deny = 0.0.0.0/0

      # Set the minimum SMB protocol version on the client end
      # Allow accessing old SMB protocols (SMB1 - COREPLUS)
      client min protocol = COREPLUS

      guest account = nobody
      map to guest = bad user
      load printers = yes
      # printing = cups
      printcap name = cups
    '';

    shares = {

      # Home Directories Share - From my old fedora days
      homes = {
        comment = "Home Directories";
        browseable = false;
        "read only" = false;
        "create mask" = "0700";
        "directory mask" = "0700";
        "valid users" = "%S";
        writable = true;
      };

      # Public Share
      NixOs23-KDE-Public = {
        path = "/home/tolga/Public";
        comment = "Public Share";
        browseable = true;
        "read only" = false;
        "guest ok" = true;
        writable = true;
        "create mask" = "0777";
        "directory mask" = "0777";
        "force user" = "tolga";
        "force group" = "samba";
      };

      # Private Share
      NixOs23-KDE-Private = {
        path = "/home/NixOs-KDE";
        comment = "Private Share";
        browseable = true;
        "read only" = false;
        "guest ok" = false;
        "create mask" = "0644";
        "directory mask" = "0755";
        "force user" = "tolga";
        "force group" = "samba";
      };

      # Printer Share
      printers = {
        comment = "All Printers";
        path = "/var/spool/samba";
        public = true;
        browseable = true;
        "guest ok" = true;
        writable = false;
        printable = true;
        "create mask" = "0700";
      };
    };
  };

  # Add a systemd tmpfiles rule that creates a directory /var/spool/samba with permissions 1777 and ownership set to root:root.
  systemd.tmpfiles.rules = [ "d /var/spool/samba 1777 root root -" ];

}
