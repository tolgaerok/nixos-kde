{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    fuzzel
    kitty
    slurp
    grim
    xfce.thunar
    xfce.tumbler
    ffmpegthumbnailer
    gthumb
    gnome.gnome-disk-utility
    arc-theme
    xorg.xlsclients
    xdg-utils
    glib
    bc
    wl-clipboard
    libnotify
    mako
    waybar
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
