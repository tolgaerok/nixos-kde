{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        arc-theme
        bc
        bluetuith
        fd
        ffmpegthumbnailer
        foot
        fuzzel
        fzf
        glib
        gnome.gnome-disk-utility
        grim
        gthumb
        kitty
        libnotify
        mako
        mate.mate-polkit
        playerctl
        ripgrep
        slurp
        swayidle
        swaylock
        unzip
        wl-clipboard
        xdg-utils
        xfce.thunar
        xfce.tumbler
        xorg.xlsclients
    ];

    hardware.bluetooth.enable = true;

    services.dbus.enable = true;
    programs.light.enable = true;

    xdg.portal = {
        enable = true;
        wlr.enable = true;
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    programs.sway = {
        enable = true;
        wrapperFeatures.gtk = true;
    };

  # Allow swaylock to unlock the computer for us
  security.pam.services.swaylock = {
    text = "auth include login";
  };
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
#
# To get list of audio outputs and switch
#   wpctl status
#   wpctl set-default <ID>
#   WIP: pw-dump | jq '.[] | select(.info.props."media.class" == "Audio/Sink") | .id'
