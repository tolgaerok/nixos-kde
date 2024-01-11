{ config, pkgs, lib, ... }:

with lib;

{

  environment.systemPackages = [ pkgs.zram-generator ];

  zramSwap = { # Source: https://docs.kernel.org/admin-guide/blockdev/zram.html

    enable =
      true; # Set to true to enable Zram, false to disable ( I have it enabled purely because i run multiple virtual machines for testing )
    #  algorithm = "lzo";   # Use LZO compression algorithm
    #  algorithm = "zstd";  # Use Zstandard (zstd) compression algorithm
    algorithm = "lz4"; # Use LZ4 compression algorithm
    memoryPercent = 50; # % of ram used for compression
    swapDevices = 1;

    # Note: Load Module
    # in terminal: sudo modprobe zram num_devices=4

    # check the status of Zram and whether the module is loaded by running the following command:   
    #   sudo lsblk
    #   lsmod | grep zram
    #
    # I have 28GB so 35% of 28GB is around 9.6GB of zram disk / swap created
    #
    # Pros and Cons:
    # - Pros:
    #   - Memory Efficiency: Zram can help manage memory efficiently, reducing the need for excessive swapping.
    #   - Performance: Zram can improve system responsiveness by minimizing disk-based swapping.
    #
    # - Cons:
    #   - Plenty of Physical RAM: With 28GB of RAM, I have ample memory. Zram's benefits may be minimal.
    #   - CPU Overhead: Zram uses CPU cycles for compression, which may not be justifiable on systems with ample RAM.
    # Zram Tmpfs Configuration

  };

}
# Extra Notes:

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

