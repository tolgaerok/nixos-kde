{ config, pkgs, lib, ... }:

{
  # --------------------------------------------------------------------
  # Permit Insecure Packages && Allow unfree packages
  # --------------------------------------------------------------------
  environment.sessionVariables.NIXPKGS_ALLOW_UNFREE = "1";
  nixpkgs.config.allowUnfree = true;

  nixpkgs.config.permittedInsecurePackages = [

    "openssl-1.1.1u"
    "openssl-1.1.1v"
    "electron-12.2.3"

  ];

}
