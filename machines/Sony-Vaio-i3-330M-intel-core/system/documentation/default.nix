{ config, pkgs, lib, ... }:

{

  # Disable or remove local documentations
  documentation = {
    doc.enable = false;
    info.enable = false;
    nixos.enable = false;
  };
}
