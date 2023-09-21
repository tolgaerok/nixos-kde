{ pkgs, ... }: {

  # ---------------------------------------------------------------------
  # My personal software collection
  # ---------------------------------------------------------------------

  environment = {
    systemPackages = with pkgs; [

      # ---------------------------------------------------------------------
      # Andriod software
      # ---------------------------------------------------------------------

      android-file-transfer           # aft-mtp-cli android-file-transfer aft-mtp-mount 
      android-tools                   # lpadd append2simg lpmake mke2fs.android mkdtboimg simg2img lpdump lpunpack ext2simg e2fsdroid adb unpack_bootimg repack_bootimg avbtool img2simg fastboot mkbootimg lpflash

      # ---------------------------------------------------------------------
      # Archive Utilities
      # ---------------------------------------------------------------------

      atool                           # apack arepack als adiff atool aunpack acat
      gzip                            # gunzip zmore zegrep zfgrep zdiff zcmp uncompress gzip znew zless zcat zforce gzexe zgrep
      lz4                             # lz4c lz4 unlz4 lz4cat
      lzip                            # lzip
      lzo
      lzop                            # lzop
      p7zip                           # 7zr 7z 7za
      rar
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
      libdvdcss
      libdvdread
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
      vscode            # conflicts with vscode-with-extensions as this is just a stand alone
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
      python311Full     # idle3.11 python3.11-config idle python3-config pydoc pydoc3 pydoc3.11 idle3 2to3-3.11 2to3 python3.11 python3 python-config python
      python311Packages.pip

      # ---------------------------------------------------------------------
      # Dsctool
      # ---------------------------------------------------------------------

      dvc
      gnuplot
      iredis
      litecli
      luigi
      mpi
      quarto
      root
      visidata

      # ---------------------------------------------------------------------
      # Scanning and Image Viewing
      # ---------------------------------------------------------------------

      nsxiv
      sane-backends
      scanbd
      sxiv

      # ---------------------------------------------------------------------
      # Downloading Videos and Files
      # ---------------------------------------------------------------------

      clipgrab
      wget

      # ---------------------------------------------------------------------
      # Messaging and Communication:
      # ---------------------------------------------------------------------

      whatsapp-for-linux

      # ---------------------------------------------------------------------
      # Scientific computing
      # ---------------------------------------------------------------------

      julia

      # ---------------------------------------------------------------------
      # Miscellaneous:
      # ---------------------------------------------------------------------

      cowsay        # fortune | cowsay -f tux   fortune | cowsay -e ^^    fortune | cowsay | lolcat
      fish
      flatpak
      fortune       # unstr rot strfile fortune
      libsForQt5.kweather
      libsForQt5.kweathercore
      lolcat        # "lolcat" for colorful output
      themechanger
      variety

      # ---------------------------------------------------------------------
      # Media and Entertainment:
      # ---------------------------------------------------------------------

      vlc
      youtube-dl

      # ---------------------------------------------------------------------
      # Picture manger
      # ---------------------------------------------------------------------

      digikam
      shotwell

      # ---------------------------------------------------------------------
      # Picture Editors
      # ---------------------------------------------------------------------

      gimp-with-plugins

      # ---------------------------------------------------------------------
      # Disc burner
      # ---------------------------------------------------------------------

      brasero

      # ---------------------------------------------------------------------
      # Remote Access and Automation:
      # ---------------------------------------------------------------------

      heroku
      powershell
      sshpass
      teamviewer

      # ---------------------------------------------------------------------
      # File Sharing & Network
      # ---------------------------------------------------------------------

      samba4Full
      cifs-utils

      # ---------------------------------------------------------------------
      # KDE Plasma tools
      # ---------------------------------------------------------------------

      ark
      filelight
      kate
      kcalc
      kdiff3
      kgpg
      krename
      libsForQt5.qt5.qttools      # qhelpgenerator linguist qtplugininfo qdistancefieldgenerator pixeltool qcollectiongenerator assistant qtdiag qdbusviewer lupdate qtpaths qtattributionsscanner lconvert designer lupdate-pro lrelease qdbus lprodump lrelease-pro
      libsForQt5.quazip           # quazip
      qt6.qttools                 # assistant qtplugininfo qdbus lrelease linguist qtdiag6 qtdiag qdbusviewer qdistancefieldgenerator pixeltool lconvert lupdate designer
      qt6Packages.quazip          # quazip

      # ---------------------------------------------------------------------
      # xscreensaver
      # ---------------------------------------------------------------------

      xscreensaver                # xscreensaver-demo xscreensaver-settings xscreensaver xscreensaver-command

      # ---------------------------------------------------------------------
      # system tools
      # ---------------------------------------------------------------------

      isoimagewriter              # isoimagewriter
      keepassxc                   # keepassxc keepassxc-cli keepassxc-proxy
      media-downloader            # media-downloader
      testdisk-qt                 # testdisk photorec fidentify qphotorec
      ventoy-full                 # ventoy   ventoy-persistent   ventoy-web   ventoy-plugson   ventoy-extend-persistent

      # ---------------------------------------------------------------------
      # USB and Device Utilities
      # ---------------------------------------------------------------------

      usbutils                    # usb-devices lsusb.py lsusb usbhid-dump

      # ---------------------------------------------------------------------
      # Other Miscellaneous Programs
      # ---------------------------------------------------------------------

      blueberry                   # blueberry-tray blueberry
      efibootmgr                  # efibootdump efibootmgr
      gum                         # gum https://github.com/charmbracelet/gum
      krusader                    # krusader

      # ---------------------------------------------------------------------
      # Libraries
      # ---------------------------------------------------------------------

      libarchive                  # bsdtar bsdcpio bsdcat
      libbtbb
      libnotify                   # Desktop Notify agent example: notify-send --icon=fcitx --app-name="DONE" "Fonts folder copied into $(whoami)" "$font_dest" -u normal
      notify-desktop              # Desktop Notify agent example: notify-desktop --icon=call-start "Incoming call"   SOURCE: https://github.com/nowrep/notify-desktop/tree/master

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
      hw-probe            # sudo -E hw-probe -all -upload
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
      inotify-tools       # inotifywait   inotifywatch    https://github.com/inotify-tools/inotify-tools/wiki
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
      gnome.zenity        # For notifications and code dialogs

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
