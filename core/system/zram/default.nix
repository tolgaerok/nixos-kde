{ config, pkgs, lib, ... }:

with lib;

{
  zramSwap = {  # Source: https://docs.kernel.org/admin-guide/blockdev/zram.html

    enable = true;
    #  algorithm = "lzo";   # Use LZO compression algorithm
    #  algorithm = "zstd";  # Use Zstandard (zstd) compression algorithm
    algorithm = "lz4";      # Use LZ4 compression algorithm
    memoryPercent = 35;     #  % of ram used for compression

    # Note: Load Module
    # in terminal: sudo modprobe zram num_devices=4

  };
}


# Zram Swap Configuration
#zramSwap = {
#  enable = true;     # Enable Zram Swap
#  algorithm = "zstd";  # Use Zstandard (zstd) compression algorithm
#  memoryPercent = 50; # Allocate 50% of RAM for Zram Swap
#};

# Zram Tmpfs Configuration
#zramTmpfs = {
#  enable = true;     # Enable Zram for tmpfs
#  algorithm = "lz4";  # Use LZ4 compression algorithm
##  memoryPercent = 25; # Allocate 25% of RAM for Zram tmpfs
#};

# Zram Extra Configuration
#zramExtra = {
#  enable = true;     # Enable Zram for an extra use case
#  algorithm = "lzo";  # Use LZO compression algorithm
#  memoryPercent = 30; # Allocate 30% of RAM for Zram extra use
#};


#You can copy and paste these configurations as needed.





