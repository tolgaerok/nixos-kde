{ pkgs, ... }: {

  #---------------------------------------------------------------------
  # Define a set of programs and their respective configurations
  #---------------------------------------------------------------------

  programs = {
    # kdeconnect = { enable = true; };
    dconf = {
      enable = true;
    };

    mtr = {
      enable = true;
    };

  };
}

