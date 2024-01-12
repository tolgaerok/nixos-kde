{ config, ... }:

{
  # --------------------------------------------------------------------
  # Permit Insecure Packages && Allow unfree packages
  # --------------------------------------------------------------------
  environment.sessionVariables.NIXPKGS_ALLOW_UNFREE = "1";
  
}

