{ config, pkgs, lib, ... }:
with lib;

{
  #---------------------------------------------------------------------
  #   Configure your nixpkgs instance
  #---------------------------------------------------------------------
  nixpkgs = {
    config = {
      # Allow Unfree Packages
      allowBroken = true;
      allowUnfree = true;

      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      # allowUnfreePredicate = _: true;

      permittedInsecurePackages = [
        "electron-12.2.3"
        "electron-24.8.6"
        "openssl-1.1.1u"
        "openssl-1.1.1v"
        "python-2.7.18.6"
        "qtwebkit-5.212.0-alpha4"

      ];

      allowUnfreePredicate = pkg:
        builtins.elem (lib.getName pkg) [
          "nvidia-settings"
          "nvidia-x11"
          "vscode"
          # "spotify"
          # "steam"
          # "steam-original"
          # "steam-run"

          # they got fossed recently so idk
          "Anytype"

        ];

      # Accept the joypixels license
      joypixels.acceptLicense = true;

    };

  };

}

