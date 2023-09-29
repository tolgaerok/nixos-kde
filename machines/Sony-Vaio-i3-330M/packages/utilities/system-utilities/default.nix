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
      inotify-tools         # inotifywait   inotifywatch    https://github.com/inotify-tools/inotify-tools/wiki
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
      gnome.zenity    # For notifications and code dialogs

      # XDG Utilities
      xdg-launch
      xdg-utils

    ];
  };
}
