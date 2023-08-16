{ pkgs, ... }: {

  # ---------------------------------------------------------------------
  # System Utilities:
  # ---------------------------------------------------------------------

  environment = {
    systemPackages = with pkgs; [

      # Disk Utilities
      gparted
      hw-probe # sudo -E hw-probe -all -upload
      ntfs3g

      # Terminal Utilities
      asunder
      bashInteractive
      cmatrix
      cowsay
      delta
      direnv
      duf
      fd
      figlet
      htop
      imagemagick
      isoimagewriter
      less
      lf
      lfs
      lsd
      lsdvd
      ncdu
      neofetch
      neovim
      parallel-full
      pciutils
      pfetch
      pkgconfig
      pmutils
      psmisc
      sl
      stow
      tig
      tldr
      tree
      vim

      # XDG Utilities
      xdg-launch
      xdg-utils

    ];
  };
}