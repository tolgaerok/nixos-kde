{ pkgs, ... }: {

  #---------------------------------------------------------------------
  # Define a set of programs and their respective configurations
  #---------------------------------------------------------------------

  programs = {
    dconf = { enable = true; };
    # kdeconnect = { enable = true; };
    mtr = { enable = true; };
  };
}

