{ pkgs, ... }: {
  # Audio/Video Editing and Playback:
  environment = {
    systemPackages = with pkgs; [

      # Multimedia Utilities
      # pulseaudioFull
      audacity
      ffmpeg
      ffmpegthumbnailer
      libdvdcss
      libdvdread
      libopus
      libvorbis
      mediainfo
      mpg123
      mplayer
      mpv
      ocamlPackages.gstreamer
      simplescreenrecorder
      video-trimmer

    ];
  };
}
