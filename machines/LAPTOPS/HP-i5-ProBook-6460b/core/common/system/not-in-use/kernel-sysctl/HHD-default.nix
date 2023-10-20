## Kernel Tweaks for Optimizing Performance

## his document outlines various kernel settings using sysctl parameters to optimize system performance, memory usage, disk writeback behavior, and network settings.

## sysctl Configuration


{
  boot.kernel.sysctl = {
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
    "vm.swappiness" = 20;                        # Adjust how aggressively the kernel swaps data from RAM to disk. Lower values prioritize keeping data in RAM. (Adjusted for 4GB RAM)
    "vm.vfs_cache_pressure" = 100;               # Adjust vfs_cache_pressure (0-1000) to manage memory used for caching filesystem objects. (Adjusted for 4GB RAM)
    
    # HDD tweaks: Adjust settings for an HDD to optimize performance.
    "vm.dirty_background_ratio" = "10";         # Set the ratio of dirty memory at which background writeback starts (10% for HDD).
    "vm.dirty_expire_centisecs" = "6000";       # Set the time at which dirty data is old enough to be eligible for writeout (6000 centiseconds for HDD).
    "vm.dirty_ratio" = "20";                    # Set the ratio of dirty memory at which a process is forced to write out dirty data (20% for HDD).
    "vm.dirty_time" = "0";                      # Disable dirty time accounting.
    "vm.dirty_writeback_centisecs" = "1000";    # Set the interval between two consecutive background writeback passes (1000 centiseconds for HDD).
  };
}