{ pkgs, ... }: {
  # Compression:
  environment = {
    systemPackages = with pkgs; [
      
      # Archive Utilities
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
      unzip

    ];
  };
}
