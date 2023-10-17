{ pkgs, ... }: {
  # Audio/Video Editing and Playback:
  environment = {
    systemPackages = with pkgs; [

      # Multimedia Utilities
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
      pulseaudioFull
      simplescreenrecorder
      video-trimmer

    ];
  };
}
