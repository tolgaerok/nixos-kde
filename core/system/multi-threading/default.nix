{ config, pkgs, lib, ... }:

{

  # Enables simultaneous use of processor threads.
  # ---------------------------------------------
  security.allowSimultaneousMultithreading = true;

}
