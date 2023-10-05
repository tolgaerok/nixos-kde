# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.

    ./core/common
    ./core/common/HD-INTEL.nix
    ./core/common/pkgs/custom-pkgs
    ./core/common/pkgs/packages.nix
    ./core/common/printer.nix
    ./hardware-configuration.nix
    #./test.nix

  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "HP_ProBook"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  services = { envfs = { enable = true; }; };

  services = {
    dbus = {
      enable = true;
      packages = with pkgs; [ dconf gcr udisks2 ];
    };
  };

  services.flatpak.enable = true;

  # For the sandboxed apps to work correctly, desktop integration portals need to be installed.
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];

  services = { fstrim = { enable = true; }; };

  services.avahi = {
    enable = true;
    nssmdns = true;
    openFirewall = true;

    publish = {
      addresses = true;
      domain = true;
      enable = true;
      hinfo = true;
      userServices = true;
      workstation = true;
    };

    extraServiceFiles = {
      smb = ''
        <?xml version="1.0" standalone='no'?><!--*-nxml-*-->
        <!DOCTYPE service-group SYSTEM "avahi-service.dtd">
        <service-group>
          <name replace-wildcards="yes">%h</name>
          <service>
            <type>_smb._tcp</type>
            <port>445</port>
          </service>
        </service-group>
      '';
    };
  };

  #---------------------------------------------------------------------
  # Allow unfree packages
  #---------------------------------------------------------------------
  environment.sessionVariables.NIXPKGS_ALLOW_UNFREE = "1";
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.permittedInsecurePackages = [ "openssl-1.1.1u" ];

  #---------------------------------------------------------------------
  # Enable the OpenSSH daemon.
  #---------------------------------------------------------------------
  services.openssh.enable = true;

  programs = {
    # command-not-found.enable = false;

    # Add Konsole (bash) aliases
    bash = {

      # Add any custom bash shell or aliases here
      shellAliases = {

        #---------------------------------------------------------------------
        # Nixos related
        #---------------------------------------------------------------------

        # rbs2 =        "sudo nixos-rebuild switch -I nixos-config=$HOME/nixos/configuration.nix";
        garbage = "sudo nix-collect-garbage --delete-older-than 7d";
        lgens =
          "sudo nix-env --profile /nix/var/nix/profiles/system --list-generations";
        neu = "sudo nix-env --upgrade";
        nopt = "sudo nix-store --optimise";
        rbs = "sudo nixos-rebuild switch";
        rebuild-all =
          "sudo nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot && sudo fstrim -av";
        switch =
          "sudo nixos-rebuild switch -I nixos-config=$HOME/nixos/configuration.nix";

        #---------------------------------------------------------------------
        # Personal scripts
        #---------------------------------------------------------------------

        htos =
          "sudo ~/scripts/MYTOOLS/scripts/Zysnc-Options/ZYSNC-HOME-TO-SERVER.sh";
        master = "sudo ~/scripts/MYTOOLS/main.sh";
        mount = "sudo ~/scripts/MYTOOLS/scripts/Mounting-Options/MOUNT-ALL.sh";
        mse = "sudo ~/scripts/MYTOOLS/MAKE-SCRIPTS-EXECUTABLE.sh";
        mynix =
          "sudo ~/scripts/MYTOOLS/scripts/COMMAN-NIX-COMMAND-SCRIPT/MyNixOS-commands.sh";
        stoh =
          "sudo ~/scripts/MYTOOLS/scripts/Zysnc-Options/ZYSNC-SERVER-TO-HOME.sh";
        trimgen =
          "sudo ~/scripts/MYTOOLS/scripts/GENERATION-TRIMMER/TrimmGenerations.sh";
        umount =
          "sudo ~/scripts/MYTOOLS/scripts/Mounting-Options/UMOUNT-ALL.sh";

        #---------------------------------------------------------------------
        # Navigate files and directories
        #---------------------------------------------------------------------

        # cd = "cd ..";
        cl = "clear";
        copy = "rsync -P";
        la = "lsd -a";
        ll = "lsd -l";
        ls = "lsd";
        lsla = "lsd -la";

        #---------------------------------------------------------------------
        # Fun stuff
        #---------------------------------------------------------------------

        icons = "sxiv -t $HOME/Pictures/icons";
        wp = "sxiv -t $HOME/Pictures/Wallpapers";

        #---------------------------------------------------------------------
        # File access
        #---------------------------------------------------------------------
        cp = "cp -riv";
        mkdir = "mkdir -vp";
        mv = "mv -iv";

        #---------------------------------------------------------------------
        # GitHub related
        #---------------------------------------------------------------------

        gitfix = "git fetch origin main && git diff --exit-code origin/main";

      };
    };
  };

  # Enable networking
  networking.networkmanager.enable = true;

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
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.tolga = {
    isNormalUser = true;
    description = "tolga erok";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      firefox
      kate
      #  thunderbird
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs;
    [
      #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      #  wget
    ];

  #---------------------------------------------------------------------
  # Automatic system upgrades, automatically reboot after an upgrade if
  # necessary
  #---------------------------------------------------------------------
  # system.autoUpgrade.allowReboot = true;  # Very annoying .
  system.autoUpgrade.enable = true;
  system.copySystemConfiguration = true;
  system.stateVersion = "23.05";
  systemd.extraConfig = "DefaultTimeoutStopSec=10s";

}
