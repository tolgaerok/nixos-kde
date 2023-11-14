{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    arc-theme
    bc
    ffmpegthumbnailer
    fuzzel
    glib
    gnome.gnome-disk-utility
    grim
    gthumb
    kitty
    libnotify
    mako
    slurp
    waybar
    wl-clipboard
    xdg-utils
    xfce.thunar
    xfce.tumbler
    xorg.xlsclients
  ];

  services.dbus.enable = true;
  programs.light.enable = true;

  programs.hyprland.enable = true;
  
}

## NOTES ##
#
# For backlight control without sudo, add user to video group
#   users.users.tolga = {
#       isNormalUser = true;
#       description = "Tolga Erok";
#       extraGroups = [ "networkmanager" "wheel" "video" "nginx" ];
#       packages = with pkgs; [];
#   };
#
# To launch chromium apps in wayland, add:
# 	--enable-features=UseOzonePlatform --ozone-platform=wayland
#
#   Can copy .desktop files from: /run/current-system/sw/share/applications/
#	to: ~/.local/share/applications
