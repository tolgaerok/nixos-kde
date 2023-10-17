{ config, pkgs, lib, ... }:

{
  #---------------------------------------------------------------------
  # Configure your nixpkgs instance
  #---------------------------------------------------------------------

  nixpkgs = {
    config = {
      # Allow Unfree Packages
      allowBroken = true;
      allowUnfree = true;

      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      # allowUnfreePredicate = _: true;

      allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
          "nvidia-settings"
          "nvidia-x11"
          "spotify"
          "steam"
          "steam-original"
          "steam-run"
          "vscode"

          # they got fossed recently so idk
          "Anytype"

        ];

      # Accept the joypixels license
      joypixels.acceptLicense = true;

      # Allow insecure or old pkgs - Help from nix package manager
      permittedInsecurePackages = [ "qtwebkit-5.212.0-alpha4" ];
    };

  };

  programs = {

    # type "fuck" to fix the last command that made you go "fuck"
    # thefuck.enable = true;

    # Please put eval "$(thefuck --alias)" in your ~/.bashrc and apply changes with source ~/.bashrc or restart your shell.
    # Or run fuck a second time to configure it automatically.
    # More details - https://github.com/nvbn/thefuck#manual-installation
    # If fuck alias already configured, to apply run source ~/.bashrc or restart your shell.

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

  #  direnv = {
  #    enable = true;
  #    nix-direnv.enable = true;
  #  };

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

