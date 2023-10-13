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

      # dialog
      doas
      fx
      fzf                             # fzf-tmux fzf-share fzf

      # ---------------------------------------------------------------------
      # Clipboard Utilities:
      # ---------------------------------------------------------------------

      # wl-clipboard                    # wl-copy wl-paste

      # ---------------------------------------------------------------------
      # Code Search and Analysis:
      # ---------------------------------------------------------------------

      ripgrep                         # A utility that combines the usability of The Silver Searcher with the raw speed of grep
                                      # rg

      ripgrep-all                     # Ripgrep, but also search in PDFs, E-Books, Office documents, zip, tar.gz, and more
                                      # rga-preproc rga

      # ---------------------------------------------------------------------
      # Utilities
      # ---------------------------------------------------------------------

      # sublime4
      direnv                          # A shell extension that manages your environment
      graalvm17-ce                    # High-Performance Polyglot VM
      mosh                            # Mobile shell (ssh replacement)
      nix-direnv                      # A fast, persistent use_nix implementation for direnv
      nixfmt                          # An opinionated formatter for Nix
      nixos-option
      vscode
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
      # python311Packages.pip

      # ---------------------------------------------------------------------
      # Dsctool
      # ---------------------------------------------------------------------

      # dvc                            # Version Control System for Machine Learning Projects
      gnuplot                        # A portable command-line driven graphing utility for many platforms
      iredis                         # A Terminal Client for Redis with AutoCompletion and Syntax Highlighting
      litecli                        # Command-line interface for SQLite
      # luigi                          # Python package that helps you build complex pipelines of batch jobs
      mpi                            # Open source MPI-3 implementation
      # quarto                         # Open-source scientific and technical publishing system built on Pandoc
      root                           # A data analysis framework
      # visidata                       # Interactive terminal multitool for tabular data

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

      # julia                         # Scientific computing       https://docs.julialang.org/en/v1/

      # ---------------------------------------------------------------------
      # Miscellaneous:
      # ---------------------------------------------------------------------

      cowsay                         # A program which generates ASCII pictures of a cow with a message
                                     #
                                     # ex: $ fortune | cowsay -f tux
                                     #     $ fortune | cowsay -e ^^
                                     #     $ fortune | cowsay | lolcat

      # fish                           # Smart and user-friendly command line shell
      flatpak                        # Linux application sandboxing and distribution framework
      fortune                        # unstr rot strfile fortune
      # libsForQt5.kdenetwork-filesharing
      libsForQt5.kweather
      libsForQt5.kweathercore
      lolcat                         # A rainbow version of cat for colorful output
                                     # "lolcat" for colorful output
      themechanger                   # A theme changing utility for Linux
      variety                        # A wallpaper manager for Linux systems
      jp2a                           # A small utility that converts JPG images to ASCII
                                     # curl -sSL -o /tmp/deb-logo.png https://github.com/tolgaerok/Debian-tolga/raw/main/WALLPAPERS/deb-logo.png
                                     # Resize the image to 101x85
                                     # convert /tmp/deb-logo.png -resize 101x98 /tmp/deb-logo-resized.png
                                     # Display the Debian ASCII art logo as the background
                                     # jp2a --background=light --colors --width="$(tput cols)" /tmp/deb-logo-resized.png

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

      # heroku                         # Everything you need to get started using Heroku
      # powershell                     # Powerful cross-platform (Windows, Linux, and macOS) shell and scripting language based on .NET
      sshpass                        # Non-interactive ssh password auth
      teamviewer                     # Desktop sharing application, providing remote support and online meetings

      # ---------------------------------------------------------------------
      # File Sharing & Network
      # ---------------------------------------------------------------------

      cifs-utils                     # Tools for managing Linux CIFS client filesystems
      samba4Full                     # The standard Windows interoperability suite of programs for Linux and Unix

      # ---------------------------------------------------------------------
      # KDE Plasma tools
      # ---------------------------------------------------------------------


      kdiff3                         # Compares and merges 2 or 3 files or directories
      ark                 # Graphical file compression/decompression utility
      filelight           # Disk usage statistics
      kate                # Advanced text editor
      kcalc               # Scientific calculator
      kgpg                # A KDE based interface for GnuPG, a powerful encryption utility
      krename
      #libsForQt5.qt5.qttools        # A cross-platform application framework for C++
                                    # qhelpgenerator linguist qtplugininfo qdistancefieldgenerator pixeltool
                                    # qcollectiongenerator assistant qtdiag qdbusviewer lupdate qtpaths
                                    # qtattributionsscanner lconvert designer lupdate-pro lrelease qdbus lprodump lrelease-pro

      # libsForQt5.quazip             # Provides access to ZIP archives from Qt 5 programs
                                    # quazip

      # qt6.qttools                   # A cross-platform application framework for C++
                                    # assistant qtplugininfo qdbus lrelease linguist qtdiag6 qtdiag qdbusviewer
                                    # qdistancefieldgenerator pixeltool lconvert lupdate designer

      # qt6Packages.quazip            # Provides access to ZIP archives from Qt programs
                                    # quazip

      # ---------------------------------------------------------------------
      # xscreensaver
      # ---------------------------------------------------------------------

      # xscreensaver                  # xscreensaver-demo xscreensaver-settings xscreensaver xscreensaver-command

      # ---------------------------------------------------------------------
      # system tools
      # ---------------------------------------------------------------------

      # isoimagewriter                # isoimagewriter
      keepassxc                     # keepassxc keepassxc-cli keepassxc-proxy
      media-downloader              # media-downloader
      # testdisk-qt                   # testdisk photorec fidentify qphotorec
      # ventoy-full                   #  # A New Bootable USB Solution
                                    # ventoy   ventoy-persistent   ventoy-web   ventoy-plugson   ventoy-extend-persistent

      # ---------------------------------------------------------------------
      # USB and Device Utilities
      # ---------------------------------------------------------------------

      usbutils                       # Tools for working with USB devices, such as lsusb

      # ---------------------------------------------------------------------
      # Other Miscellaneous Programs
      # ---------------------------------------------------------------------

      blueberry                     # Bluetooth configuration tool
                                    # blueberry-tray blueberry

      efibootmgr                    # A Linux user-space application to modify the Intel Extensible Firmware Interface (EFI) Boot Manager
                                    # efibootdump efibootmgr

      gum                           # gum https://github.com/charmbracelet/gum

      krusader                      # Norton/Total Commander clone for KDE
                                    # krusader

      espeak-classic                # Compact open source software speech synthesizer
                                    # espeak
                                    # espeak -v en+m7 -s 165 "Welcome! This script will! initiate! the! basic! setup! for your system. Thank you for using! my configuration." --punct=","

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

      gparted                       # Graphical disk partitioning tool

      hw-probe                      # Probe for hardware, check operability and find drivers
                                    #
                                    # sudo -E hw-probe -all -upload

      ntfs3g                        # FUSE-based NTFS driver with full write support

      # ---------------------------------------------------------------------
      # Terminal Utilities
      # ---------------------------------------------------------------------

      asunder                       # A graphical Audio CD ripper and encoder for Linux
      bashInteractive               # GNU Bourne-Again Shell, the de facto standard shell on Linux (for interactive use)
      cmatrix                       # Simulates the falling characters theme from The Matrix movie
      delta                         # A syntax-highlighting pager for git
      duf                           # Disk Usage/Free Utility
      fd                            # A simple, fast and user-friendly alternative to find
      figlet                        # Program for making large letters out of ordinary text
      htop                          # An interactive process viewer
      imagemagick                   # A software suite to create, edit, compose, or convert bitmap images

      inotify-tools                 # A set of command-line programs providing a simple interface to inotify.
                                    # inotifywait   inotifywatch
                                    # Source:  https://github.com/inotify-tools/inotify-tools/wiki

      gnome.zenity                  # Tool to display dialogs from the commandline and shell scripts
      less                          # A more advanced file pager than ‘more’
      lf                            # A terminal file manager written in Go and heavily inspired by ranger
      lfs                           # Get information on your mounted disks
      lsd                           # The next gen ls command
      lsdvd                         # Display information about audio, video, and subtitle tracks on a DVD
      ncdu                          # Disk usage analyzer with an ncurses interface
      neofetch                      # A fast, highly customizable system info script
      neovim                        # Vim text editor fork focused on extensibility and agility
      parallel-full                 #
      pciutils                      # A collection of programs for inspecting and manipulating configuration of PCI devices
      pfetch                        # A pretty system information tool written in POSIX sh
      pmutils                       # A small collection of scripts that handle suspend and resume on behalf of HAL
      psmisc                        # A set of small useful utilities that use the proc filesystem (such as fuser, killall and pstree)
      rPackages.pkgconfig           # Set configuration options on a per-package basis. Options set by a given package only apply to that package, other packages are unaffected.
      sl                            # Steam Locomotive runs across your terminal when you type 'sl'
      stow                          # A tool for managing the installation of multiple software packages in the same run-time directory tree
      tig                           # Text-mode interface for git
      tldr                          # Simplified and community-driven man pages
      tree                          # Command to produce a depth indented directory listing
      vim                           # The most popular clone of the VI editor

      # ---------------------------------------------------------------------
      # XDG Utilities
      # ---------------------------------------------------------------------

      xdg-launch                    # A command line XDG compliant launcher and tools
      xdg-utils                     # A set of command line tools that assist applications with a variety of desktop integration tasks

      #---------------------------------------------------------------------
      # Office and Productivity:
      #---------------------------------------------------------------------

      deepin.deepin-calculator      # An easy to use calculator for ordinary users
      wpsoffice                     # Office suite, formerly Kingsoft Office

      #---------------------------------------------------------------------
      # New additions:
      #---------------------------------------------------------------------

      # megasync          # Easy automated syncing between your computers and your MEGA Cloud Drive
      # onedrive          # A complete tool to interact with OneDrive on Linux
      rclone            # Command line program to sync files and directories to and from major cloud storage
      rclone-browser    # Graphical Frontend to Rclone written in Qt
      glances           # glances   : Cross-platform curses-based monitoring tool


      #-----------------------------------------------------------------  
      # Extra Audio packages
      #-----------------------------------------------------------------

      alsa-utils
      pavucontrol
      pulseaudio
      pulsemixer

      #-----------------------------------------------------------------  
      # Extra Misc packages
      #-----------------------------------------------------------------

      glxinfo
      rocm-opencl-icd
      rocm-opencl-runtime
      libva
      libva-utils
      glxinfo

      appimage-run
      espeak-classic
      firefox

    ]; 
  };
}
