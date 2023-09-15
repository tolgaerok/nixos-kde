{ config, pkgs, lib, ... }:

{

  # Disable or remove local documentations for faster rebuilding
  documentation = {

    enable = false;
    dev.enable = false;
    doc.enable = false;
    info.enable = false;
    man.enable = false;
    nixos.enable = false;

  };
}
