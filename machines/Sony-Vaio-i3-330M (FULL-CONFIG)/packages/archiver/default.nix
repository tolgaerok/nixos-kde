{ pkgs, ... }: {
  # Compression:
  environment = {
    systemPackages = with pkgs; [

      # Archive Utilities
      atool
      gzip
      lz4
      lzip
      lzo
      lzop
      p7zip
      rar
      rzip
      unzip
      xz
      zip
      zstd

    ];
  };
}
