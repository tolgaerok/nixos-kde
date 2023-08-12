{ config, pkgs, lib, ... }:

{

  imports = [

    # Configuration for  XDG Desktop Portal integration
    ./xdg-portal.nix

  ];
}
