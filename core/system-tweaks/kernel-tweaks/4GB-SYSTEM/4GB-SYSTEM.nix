{ config, ... }:

# Control how and when data is written from memory to disk, which can have an impact on system performance and responsiveness.
# useful for optimizing memory usage, disk writeback behavior, network settings, and other low-level kernel behaviors.

{
  boot.kernel.sysctl = {

    #---------------------------------------------------------------------
    #   Network and memory-related optimizationss for 4GB
    #---------------------------------------------------------------------
    "kernel.sysrq" = 1;                         # Enable SysRQ for rebooting the machine properly if it freezes. [Source](https://oglo.dev/tutorials/sysrq/index.html)
    "net.core.netdev_max_backlog" = 30000;      # Help prevent packet loss during high traffic periods.
    "net.core.rmem_default" = 131072;           # Default socket receive buffer size, improving network performance and applications that use sockets.
    "net.core.rmem_max" = 16777216;             # Maximum socket receive buffer size, determining the amount of data that can be buffered in memory for network operations.
    "net.core.wmem_default" = 131072;           # Default socket send buffer size, improving network performance and applications that use sockets.
    "net.core.wmem_max" = 16777216;             # Maximum socket send buffer size, determining the amount of data that can be buffered in memory for network operations.
    "net.ipv4.ipfrag_high_threshold" = 8388608; # Reduce the chances of fragmentation.
    "net.ipv4.tcp_keepalive_intvl" = 30;        # TCP keepalive interval between probes to detect if a connection is still alive.
    "net.ipv4.tcp_keepalive_probes" = 5;        # TCP keepalive probes to detect if a connection is still alive.
    "net.ipv4.tcp_keepalive_time" = 300;        # TCP keepalive interval in seconds to detect if a connection is still alive.
    "vm.dirty_background_bytes" = 8388608;      # Data (8 MB) modified in memory and needs to be written to disk. (Adjusted for 4GB RAM)
    "vm.dirty_bytes" = 25165824;                # Data (24 MB) modified in memory and needs to be written to disk. (Adjusted for 4GB RAM)
    "vm.min_free_kbytes" = 32768;               # Minimum free memory for safety (in KB), helping prevent memory exhaustion situations. (Adjusted for 4GB RAM)
    "vm.swappiness" = 20;                       # Adjust how aggressively the kernel swaps data from RAM to disk. Lower values prioritize keeping data in RAM. (Adjusted for 4GB RAM)
    "vm.vfs_cache_pressure" = 100;              # Adjust vfs_cache_pressure (0-1000) to manage memory used for caching filesystem objects. (Adjusted for 4GB RAM)

  };
}