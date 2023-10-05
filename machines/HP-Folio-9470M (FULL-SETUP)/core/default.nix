{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./services
      ./system
      ./nix
      ./programs
      ./custom-pkgs
      ./packages
    ];

 }
