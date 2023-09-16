{ config, pkgs, lib, ... }:

{

  # Disable or remove local documentations for faster rebuilding
  # Only install the docs I use
  documentation.doc.enable = false;
  documentation.enable = true;
  documentation.info.enable = false;
  documentation.man.enable = true;
  documentation.nixos.enable = false;

}
