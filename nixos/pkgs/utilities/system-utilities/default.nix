{ pkgs, ... }: 
{
  # System Utilities:
  environment = {
    systemPackages = with pkgs; [
      xdg-launch
      xdg-utils
      cmatrix
      isoimagewriter
      fd
      less
      lsd
      lsdvd
      ncdu
      neofetch
      neovim
      ntfs3g
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
      htop
      asunder
      bashInteractive
      cowsay
      delta
      direnv
      duf
      figlet
      gparted
      graphviz
      imagemagick
      hw-probe         # sudo -E hw-probe -all -upload
    ];
  };
}
