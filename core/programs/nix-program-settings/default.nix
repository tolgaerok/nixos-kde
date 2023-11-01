{ config, pkgs, lib, ... }:
with lib;

{

  programs = {

    # allow users to mount fuse filesystems with allow_other
    fuse.userAllowOther = true;

    # help manage android devices via command line
    adb.enable = true;

    # "saying java is good because it runs on all systems is like saying
    # anal sex is good because it works on all species"
    # - sun tzu
    java = {
      enable = false;
      #  package = pkgs.jre;
    };

    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

  };

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [

      curl
      glib
      glibc
      icu
      libsecret
      libunwind
      libuuid

      # openssl
      stdenv.cc.cc
      util-linux
      zlib

      # graphical
      freetype
      libglvnd
      libnotify
      SDL2
      vulkan-loader
      gdk-pixbuf
      xorg.libX11

    ];
  };
}
