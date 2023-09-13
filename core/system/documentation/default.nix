{ config, pkgs, lib, ... }:

{

  # Disable or remove local documentations for faster rebuilding
  documentation = {

    enable = true;
    dev.enable = false;
    doc.enable = false;
    info.enable = false;
    man.enable = true;
    nixos.enable = false;

  };
}
