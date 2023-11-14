{ ... }:

{
  #---------------------------------------------------------------------  
  # Import default.nix from folders below
  #---------------------------------------------------------------------

  imports = [

    #---------------------------------------------------------------------
    # Editor
    #---------------------------------------------------------------------
 
    #./database        # dbeaver, pgmodeler, sqlitebrowser
    ./dsctool

    #---------------------------------------------------------------------
    # Basic
    #---------------------------------------------------------------------
   
    ./archiver

    #---------------------------------------------------------------------
    # Multimedia
    #---------------------------------------------------------------------

    ./audio-video
    ./image
    ./multi-media     # digikam, shotwell, gimp-with-plugins, brasero, vlc, youtube-dl

    #---------------------------------------------------------------------
    # Programming
    #---------------------------------------------------------------------
    
    ./custom-pkgs     # My personal system-wide pkgs
    ./devlopment
    # ./julia
    
    #---------------------------------------------------------------------
    # Desktop
    #---------------------------------------------------------------------

    ./internet        # clipgrab, wget, discord, whatsapp-for-linux, FF, Chrome
    ./networking      # samba4Full, clif-utilities, teamviewer, openssh, sshpass, iwd
    # ./screensaver
    ./wps
    # ./libreoffice-various     # libreoffice, libreoffice-qt, qownnotes, zotero

    #---------------------------------------------------------------------
    # System tools
    #---------------------------------------------------------------------

    ./andriod
    ./misc
    ./tools            # isoimagewriter, keepassxc, media-downloader, testdisk-qt, ventoy-full
    ./utilities

    #---------------------------------------------------------------------
    # Enable flatpak
    #---------------------------------------------------------------------

    ./flatpak

  ];

}
