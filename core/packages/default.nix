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
    ./multi-media             # digikam, shotwell, gimp-with-plugins, brasero, vlc, youtube-dl

    #---------------------------------------------------------------------
    # Programming
    #---------------------------------------------------------------------
    
    ./custom-pkgs             # My personal system-wide pkgs
    ./devlopment
    ./julia
    # ./vscodium
    # ./vscode
    
    #---------------------------------------------------------------------
    # Desktop
    #---------------------------------------------------------------------

    ./internet                # clipgrab, wget, discord, whatsapp-for-linux, telegram, element, FF, Chrome
    ./libreoffice-various     # libreoffice-fresh qownnotes, zotero
    ./networking              # samba4Full, clif-utilities, teamviewer, openssh, sshpass, iwd
    ./plasma
    ./theme-packages
    ./screensaver
    ./wps

    #---------------------------------------------------------------------
    # System tools
    #---------------------------------------------------------------------

    # ./ventoy-full
    ./andriod
    ./misc
    ./openssl
    ./tools                   # isoimagewriter, keepassxc, media-downloader, testdisk-qt, ventoy-full
    ./utilities

    #---------------------------------------------------------------------
    # Enable flatpak
    #---------------------------------------------------------------------

    ./flatpak

  ];

}
