{ config, pkgs, ... }:
let
  baseconfig = { allowUnfree = true; };
  unstable = import <nixos-unstable> { config = baseconfig; };
in { environment.systemPackages = with pkgs; [ unstable.ventoy-full ]; }
