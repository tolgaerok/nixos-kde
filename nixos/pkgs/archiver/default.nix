{ pkgs, ... }: 
{
  # Compression:
  environment = {
    systemPackages = with pkgs; [
      rar
      xz
      zip
      zstd
      p7zip
      rzip
      lz4
      lzip
      lzo
      lzop
      gzip
      atool
    ];
  };
}
