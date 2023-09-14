{ config, pkgs, stdenv, lib, ... }:

{

  imports = [

    ../../core
    ../../core/gpu/nvidia/nvidia-stable-opengl # NVIDIA with hardware acceleration (Open-GL) for GT-1030++
    ./EliteDesk-800-G1-hardware-configuration.nix
    ./user/SOS/SOS.nix
    ./user/tolga/tolga.nix

  ];

  #nix.nixPath =
  #  [ "nixpkgs=https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz" ];
  # Set the Nixpkgs channel to 'nixos-unstable'.
  # Set the Nixpkgs channel to 'nixos-unstable'.
  # nixpkgs.config = {
  #   packageOverrides = pkgs: {
  #     unstable = import <nixos-unstable> {
  #      inherit pkgs;
  #      config = config.nixpkgs.config;
  #    };
  #  };
  #};

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "HP-G800"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  environment.systemPackages = with pkgs; [
    firefox
    kate
    # thunderbird
  ];

  # Including this
  nixpkgs.config.permittedInsecurePackages =
    [ "openssl-1.1.1u" "openssl-1.1.1v" ];

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.xserver.displayManager.sddm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # --------------------------------------------------------------------
  # Audio
  #---------------------------------------------------------------------

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  sound.enable = true;

  services.pipewire = {
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  #---------------------------------------------------------------------
  # Automatic system upgrades, automatically reboot after an upgrade if
  # necessary
  #---------------------------------------------------------------------

  # system.autoUpgrade.allowReboot = true;  # Very annoying .

  system.autoUpgrade.enable = true;
  system.copySystemConfiguration = true;
  system.stateVersion = "23.05";
  systemd.extraConfig = "DefaultTimeoutStopSec=10s";
  #---------------------------------------------------------------------
  # Switch to most recent kernel available
  #---------------------------------------------------------------------

  zramSwap.enable = true;

}
