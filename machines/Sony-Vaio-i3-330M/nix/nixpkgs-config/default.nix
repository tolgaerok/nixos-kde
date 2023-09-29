{ pkgs, ... }:

{
  #---------------------------------------------------------------------
  # Configure your nixpkgs instance
  #---------------------------------------------------------------------

  nixpkgs = {
    config = {
      # Allow Unfree Packages
      allowUnfree = true;
      allowBroken = true;

      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;

      # Accept the joypixels license
      joypixels.acceptLicense = true;

      # Allow insecure or old pkgs - Help from nix package manager
      permittedInsecurePackages = [ "openssl-1.1.1u" "python-2.7.18.6" ];
    };
  };
}

