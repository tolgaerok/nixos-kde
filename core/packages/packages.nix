{ pkgs, ... }: {

  # ---------------------------------------------------------------------
  # My personal software collection
  # ---------------------------------------------------------------------

  services.teamviewer.enable = true;

  environment = {
    systemPackages = with pkgs; [

      # ---------------------------------------------------------------------
      # Andriod software
      # ---------------------------------------------------------------------

      android-file-transfer           # aft-mtp-cli android-file-transfer aft-mtp-mount 
      android-tools                   # lpadd append2simg lpmake mke2fs.android mkdtboimg simg2img lpdump lpunpack ext2simg e2fsdroid adb unpack_bootimg repack_bootimg avbtool img2simg fastboot mkbootimg lpflash
      droidcam                        # Linux client for DroidCam app 
      scrcpy                          # Display and control Android devices over USB or TCP/IP
      waydroid                        # Waydroid is a container-based approach to boot a full Android system on a regular GNU/Linux system

      # ---------------------------------------------------------------------
      # Archive Utilities
      # ---------------------------------------------------------------------

      atool                           # apack arepack als adiff atool aunpack acat
      gzip                            # gunzip zmore zegrep zfgrep zdiff zcmp uncompress gzip znew zless zcat zforce gzexe zgrep
      lz4                             # lz4c lz4 unlz4 lz4cat
      lzip                            # lzip
      lzo                             # Real-time data (de)compression library
      lzop                            # lzop
      p7zip                           # 7zr 7z 7za
      rar                             # Utility for RAR archives
      rzip                            # rzip
      unzip                           # zipinfo unzipsfx zipgrep funzip unzip
      xz                              # lzfgrep lzgrep lzma xzegrep xz unlzma lzegrep lzmainfo lzcat xzcat xzfgrep xzdiff lzmore xzgrep xzdec lzdiff xzcmp lzmadec xzless xzmore unxz lzless lzcmp
      zip                             # zipsplit zipnote zip zipcloak
      zstd                            # zstd pzstd zstdcat zstdgrep zstdless unzstd zstdmt

      # ---------------------------------------------------------------------
      # Multimedia Utilities
      # ---------------------------------------------------------------------

      audacity                        # audacity
      ffmpeg                          # ffprobe ffmpeg
      ffmpegthumbnailer               # ffmpegthumbnailer
      libdvdcss                       # A library for decrypting DVDs
      libdvdread                      # A library for reading DVDs
      libopus
      libvorbis
      mediainfo                       # mediainfo
      mpg123                          # out123 conplay mpg123-id3dump mpg123 mpg123-strip
      mplayer                         # gmplayer mplayer mencoder
      mpv
      ocamlPackages.gstreamer         # mpv mpv_identify.sh umpv
      simplescreenrecorder            # ssr-glinject simplescreenrecorder
      video-trimmer                   # video-trimmer

      # ---------------------------------------------------------------------
      # Deduplicating archiver with compression and encryption softwar
      # ---------------------------------------------------------------------

      borgbackup                      # borgfs, borg    Deduplicating archiver with compression and encryption
      restic                          # restic          A backup program that is fast, efficient and secure       https://www.youtube.com/watch?v=MzJbSf7GQ1E
      restique                        # restique        Restic GUI for Desktop/Laptop Backups

      # ---------------------------------------------------------------------
      # Database related
      # ---------------------------------------------------------------------

      dbeaver                         # dbeaver
      pgmodeler                       # pgmodeler-cli pgmodeler pgmodeler-ch pgmodeler-se
      sqlitebrowser                   # sqlitebrowser

      # --------------------------------------------------------------------- 
      # cli-utilities
      # ---------------------------------------------------------------------

      dialog
      doas
      fx
      fzf                             # fzf-tmux fzf-share fzf

      # ---------------------------------------------------------------------
      # Clipboard Utilities:
      # ---------------------------------------------------------------------

      wl-clipboard                    # wl-copy wl-paste

      # ---------------------------------------------------------------------
      # Code Search and Analysis:
      # ---------------------------------------------------------------------

      ripgrep                         # rg
      ripgrep-all                     # rga-preproc rga

      # ---------------------------------------------------------------------
      # Utilities
      # ---------------------------------------------------------------------

      # sublime4
      direnv
      graalvm17-ce
      mosh
      nix-direnv
      nixfmt
      nixos-option
      vscode                          # conflicts with vscode-with-extensions as this is just a stand alone
      vscode-extensions.brettm12345.nixfmt-vscode
      vscode-extensions.mkhl.direnv

      # ---------------------------------------------------------------------
      # Github related
      # ---------------------------------------------------------------------

      git
      hut

      # ---------------------------------------------------------------------
      # Programming Languages and Tools:
      # ---------------------------------------------------------------------
      scala-cli
      python311Full                 # idle3.11 python3.11-config idle python3-config pydoc pydoc3 pydoc3.11 idle3 2to3-3.11 2to3 python3.11 python3 python-config python
      python311Packages.pip

      # ---------------------------------------------------------------------
      # Dsctool
      # ---------------------------------------------------------------------

      dvc                            # Version Control System for Machine Learning Projects
      gnuplot                        # A portable command-line driven graphing utility for many platforms
      iredis                         # A Terminal Client for Redis with AutoCompletion and Syntax Highlighting
      litecli                        # Command-line interface for SQLite
      luigi                          # Python package that helps you build complex pipelines of batch jobs
      mpi                            # Open source MPI-3 implementation
      quarto                         # Open-source scientific and technical publishing system built on Pandoc
      root                           # A data analysis framework
      visidata                       # Interactive terminal multitool for tabular data

      # ---------------------------------------------------------------------
      # Scanning and Image Viewing
      # ---------------------------------------------------------------------

      nsxiv                          # New Suckless X Image Viewe
      sane-backends                  # SANE (Scanner Access Now Easy) backends
      scanbd                         # Scanner button daemon
      sxiv                           # Simple X Image Viewer

      # ---------------------------------------------------------------------
      # Downloading Videos and Files
      # ---------------------------------------------------------------------

      clipgrab                       # Video downloader for YouTube and other sites
      wget                           # Tool for retrieving files using HTTP, HTTPS, and FTP

      # ---------------------------------------------------------------------
      # Messaging and Communication:
      # ---------------------------------------------------------------------

      whatsapp-for-linux             # Whatsapp desktop messaging app


      # ---------------------------------------------------------------------
      # Scientific computing
      # ---------------------------------------------------------------------

      julia

      # ---------------------------------------------------------------------
      # Miscellaneous:
      # ---------------------------------------------------------------------

      cowsay                         # A program which generates ASCII pictures of a cow with a message
                                     #
                                     # ex: $ fortune | cowsay -f tux  
                                     #     $ fortune | cowsay -e ^^   
                                     #     $ fortune | cowsay | lolcat
      fish                           # Smart and user-friendly command line shell
      flatpak                        # Linux application sandboxing and distribution framework
      fortune                        # unstr rot strfile fortune
      libsForQt5.kweather
      libsForQt5.kweathercore
      lolcat                         # A rainbow version of cat for colorful output                         
                                     # "lolcat" for colorful output
      themechanger                   # A theme changing utility for Linux
      variety                        # A wallpaper manager for Linux systems

      # ---------------------------------------------------------------------
      # Media and Entertainment:
      # ---------------------------------------------------------------------

      vlc                            # Cross-platform media player and streaming server
      youtube-dl                     # Command-line tool to download videos from YouTube.com and other sites

      # ---------------------------------------------------------------------
      # Picture manger
      # ---------------------------------------------------------------------

      digikam                        # Photo Management Program
      shotwell                       # Popular photo organizer for the GNOME desktop

      # ---------------------------------------------------------------------
      # Picture Editors
      # ---------------------------------------------------------------------

      gimp-with-plugins              # The GNU Image Manipulation Program

      # ---------------------------------------------------------------------
      # Disc burner
      # ---------------------------------------------------------------------

      brasero                        # A Gnome CD/DVD Burner

      # ---------------------------------------------------------------------
      # Remote Access and Automation:
      # ---------------------------------------------------------------------

      heroku                         # Everything you need to get started using Heroku
      powershell                     # Powerful cross-platform (Windows, Linux, and macOS) shell and scripting language based on .NET
      sshpass                        # Non-interactive ssh password auth
      teamviewer                     # Desktop sharing application, providing remote support and online meetings

      # ---------------------------------------------------------------------
      # File Sharing & Network
      # ---------------------------------------------------------------------

      samba4Full                     # The standard Windows interoperability suite of programs for Linux and Unix
      cifs-utils                     # Tools for managing Linux CIFS client filesystems

      # ---------------------------------------------------------------------
      # KDE Plasma tools
      # ---------------------------------------------------------------------

      kdiff3                         # Compares and merges 2 or 3 files or directories
      libsForQt5.ark                 # Graphical file compression/decompression utility
      libsForQt5.filelight           # Disk usage statistics
      libsForQt5.kate                # Advanced text editor
      libsForQt5.kcalc               # Scientific calculator
      libsForQt5.kgpg                # A KDE based interface for GnuPG, a powerful encryption utility
      krename
      libsForQt5.qt5.qttools        # A cross-platform application framework for C++        
                                    # qhelpgenerator linguist qtplugininfo qdistancefieldgenerator pixeltool qcollectiongenerator assistant qtdiag qdbusviewer lupdate qtpaths qtattributionsscanner lconvert designer lupdate-pro lrelease qdbus lprodump lrelease-pro
      
      libsForQt5.quazip             # Provides access to ZIP archives from Qt 5 programs
                                    # quazip

      qt6.qttools                   # # A cross-platform application framework for C++
                                    # assistant qtplugininfo qdbus lrelease linguist qtdiag6 qtdiag qdbusviewer qdistancefieldgenerator pixeltool lconvert lupdate designer
      
      qt6Packages.quazip            # Provides access to ZIP archives from Qt programs
                                    # quazip

      # ---------------------------------------------------------------------
      # xscreensaver
      # ---------------------------------------------------------------------

      xscreensaver                  # xscreensaver-demo xscreensaver-settings xscreensaver xscreensaver-command

      # ---------------------------------------------------------------------
      # system tools
      # ---------------------------------------------------------------------

      isoimagewriter                # isoimagewriter
      keepassxc                     # keepassxc keepassxc-cli keepassxc-proxy
      media-downloader              # media-downloader
      testdisk-qt                   # testdisk photorec fidentify qphotorec
      ventoy-full                   # ventoy   ventoy-persistent   ventoy-web   ventoy-plugson   ventoy-extend-persistent

      # ---------------------------------------------------------------------
      # USB and Device Utilities
      # ---------------------------------------------------------------------

      usbutils                      # usb-devices lsusb.py lsusb usbhid-dump

      # ---------------------------------------------------------------------
      # Other Miscellaneous Programs
      # ---------------------------------------------------------------------

      blueberry                     # blueberry-tray blueberry
      efibootmgr                    # efibootdump efibootmgr
      gum                           # gum https://github.com/charmbracelet/gum
      krusader                      # krusader

      # ---------------------------------------------------------------------
      # Libraries
      # ---------------------------------------------------------------------

      libarchive                    # bsdtar bsdcpio bsdcat
      libbtbb
      libnotify                     # Desktop Notify agent example: notify-send --icon=fcitx --app-name="DONE" "Fonts folder copied into $(whoami)" "$font_dest" -u normal
      notify-desktop                # Desktop Notify agent example: notify-desktop --icon=call-start "Incoming call"   SOURCE: https://github.com/nowrep/notify-desktop/tree/master

      # ---------------------------------------------------------------------
      # File Transfer:
      # ---------------------------------------------------------------------

      filezilla
      libfilezilla
      rsync
      transmission-gtk
      zsync

      # ---------------------------------------------------------------------
      # Disk Utilities
      # ---------------------------------------------------------------------

      gparted
      hw-probe                      # sudo -E hw-probe -all -upload
      ntfs3g

      # ---------------------------------------------------------------------
      # Terminal Utilities
      # ---------------------------------------------------------------------

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
      inotify-tools                 # inotifywait   inotifywatch    https://github.com/inotify-tools/inotify-tools/wiki
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
      gnome.zenity                  # For notifications and code dialogs

      # ---------------------------------------------------------------------
      # XDG Utilities
      # ---------------------------------------------------------------------

      xdg-launch
      xdg-utils

      #---------------------------------------------------------------------
      # Office and Productivity:
      #---------------------------------------------------------------------

      wpsoffice
      deepin.deepin-calculator

    ];
  };
}
