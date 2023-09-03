{ ... }:

{
  #---------------------------------------------------------------------  
  # Import default.nix from folders below
  #---------------------------------------------------------------------

  imports = [

    #---------------------------------------------------------------------
    # Editor
    #---------------------------------------------------------------------
 
    ./database        # dbeaver, pgmodeler, sqlitebrowser
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
    ./julia
    # ./vscodium
    # ./vscode
    
    #---------------------------------------------------------------------
    # Desktop
    #---------------------------------------------------------------------

    ./internet        # clipgrab, wget, discord, whatsapp-for-linux, telegram, element, FF, Chrome
    ./networking      # samba4Full, clif-utilities, teamviewer, openssh, sshpass, iwd
    ./screensaver
    ./wps
    ./libreoffice-various     # libreoffice-fresh qownnotes, zotero

    #---------------------------------------------------------------------
    # System tools
    #---------------------------------------------------------------------

    ./andriod
    ./misc
    ./tools            # isoimagewriter, keepassxc, media-downloader, testdisk-qt, ventoy-full
    ./utilities
    # ./ventoy-full

    #---------------------------------------------------------------------
    # Enable flatpak
    #---------------------------------------------------------------------

    ./flatpak

  ];

}
