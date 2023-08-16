{ config, pkgs, lib, ... }:

let

  xxx = pkgs.writeScriptBin "xxx" ''

  '';

in {

  #---------------------------------------------------------------------
  # Type: xxx in terminal to execute above bash script
  #---------------------------------------------------------------------

  environment.systemPackages = [ xxx ];
}
