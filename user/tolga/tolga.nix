{ config, pkgs, stdenv, lib, attrs, ... }:

#---------------------------------------------------------------------
# Tolga Erok
# 10/6/2023
# My personal NIXOS KDE user configuration 
# ¯\_(ツ)_/¯
#---------------------------------------------------------------------

{
  imports = [
    ./home-network/mnt-samba.nix

  ];

  #---------------------------------------------------------------------
  # Set your time zone.
  #---------------------------------------------------------------------
  time.timeZone = "Australia/Perth";

  #---------------------------------------------------------------------
  # Select internationalisation properties.
  #---------------------------------------------------------------------
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

  #---------------------------------------------------------------------
  # Configure keymap in X11
  #---------------------------------------------------------------------
  services.xserver = {
    layout = "au";
    xkbVariant = "";
  };

  #---------------------------------------------------------------------
  # User Configuration
  #---------------------------------------------------------------------
  users.users.tolga = {
    # group = "tolga";
    createHome = true;
    description = "King_Tolga";
    home = "/home/tolga/";
    homeMode = "0755";
    isNormalUser = true;
    uid = 1000;

    extraGroups = [
      "adbusers"
      "audio"
      "corectrl"
      "disk"
      "docker"
      "input"
      "libvirtd"
      "lp"
      "minidlna"
      "mongodb"
      "mysql"
      "network"
      "networkmanager"
      "postgres"
      "power"
      "samba"
      "scanner"
      "smb"
      "sound"
      "storage"
      "systemd-journal"
      "udev"
      "users"
      "video"
      "wheel" # Enable ‘sudo’ for the user.
    ];

    packages = [ pkgs.home-manager ];

    #---------------------------------------------------------------------
    # Create new password => mkpasswd -m sha-512
    #---------------------------------------------------------------------
    hashedPassword =
      "$6$yn6swk2CdH.7MJu/$GtdPxLNz0kyNmDXZ7FsCNVKvgd16Lk3xxp5AGxzq/ojyM6uderrA5SSTYz4Y8cvu97BHi7mCg6pB8zfhlUjHd.";

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDrS+VQMWkyNZ70Ym/TZoozhPfLpj9Rx+IlswOK01ZVx kintolga@gmail.com"
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDd6n8jJw4AsjoUVl/tlnBIx0lfWN7Y9T16cYAuezidSq3kvKlsyd6xDDj/HZg6TPBH7KPyTc+ewFAC81syIekPk27jugFOniN4Bxdqbh7NX5pI7KTzaSkf7Mrw2miBj4J4nZa+Uic3wXKb0rr4udFhXKl7g7AO02D6sFSe/aqKVbGJCdG6TD4CF+TzUiSsQgvynPPIL1hGBDZZ7LXbk3qTrpOOEYmkffJFGDCI/1INNVhKmPKLFqoXxMT+YvG0NBxuGO/voxVHmR0bPBIsycmSZV8jOsDz6jR86KRvFGd1ZLXXEM+q4hhKb3qHOH2siLV1e4+RsmrwXSade3KIQO0Ob2dzwwvlj2juJCDY41OijRgtTEEvO5YTo5Ito12d+06fNzodMorGvmp7Arw8KnpseAqPswiH/etXClq8htOB4uQ18tb1HAWhKILfhBfP+sqi4mLmvxSqH1ZTDq3Ys2v+iUIL6eNB9ottpJSRrOR3zEVq/4DHsuhszyHWjFCWeAEEGqwVt2tBMV4SOuOoyjkAq3CcaBqjThDL1n/LudaruK07ZUPW7RfTBtnze29ZmY1ikau7+63wQRuyhAFFzFRM+zyJZeCmYfX5iPFEGNg5UDvrYFzQlYwqKmP1LhSGwILdvE3YIChs6lcw4XDqzhENq0ZvYMCWTfFGeM78kv58Yw== kingtolga@gmail.com"
    ];

    openssh.authorizedKeys.keyFiles = [
      /home/tolga/.ssh/id_rsa.pub
      /home/tolga/.ssh/id_ed25519.pub

    ];

  };

  services.cron = {
    enable = true;
    systemCronJobs = [
      "0,5,10,15,20,25,30,35,40,45,50,55 * * * * root sh /home/tolga/Desktop/none.sh"
    ];
  };

}
