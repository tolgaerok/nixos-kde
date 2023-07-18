{ pkgs, ... }: 
{
  # Audio/Video Editing and Playback:
  environment = {
    systemPackages = with pkgs; [
      audacity
      ffmpeg
      ffmpegthumbnailer
      libdvdcss
      libdvdread
      libopus
      libvorbis
      mpg123
      mplayer
      mpv
      ocamlPackages.gstreamer
      pulseaudioFull
      shotwell
      simplescreenrecorder
      video-trimmer
    ];
  };
}
