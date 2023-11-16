{ config,  ... }:

# Control how and when data is written from memory to disk, which can have an impact on system performance and responsiveness.  
# useful for optimizing memory usage, disk writeback behavior, network settings, and other low-level kernel behaviors.

{
  boot.kernel.sysctl = {

    #---------------------------------------------------------------------
    #   Network and memory-related optimizationss for desktop 16GB
    #---------------------------------------------------------------------
    "kernel.sysrq" = 1;                         # Enable SysRQ for rebooting the machine properly if it freezes. [Source](https://oglo.dev/tutorials/sysrq/index.html)
    "net.core.netdev_max_backlog" = 30000;      # Help prevent packet loss during high traffic periods.
    "net.core.rmem_default" = 262144;           # Default socket receive buffer size, improve network performance & applications that use sockets. Adjusted for 16GB RAM.
    "net.core.rmem_max" = 33554432;             # Maximum socket receive buffer size, determine the amount of data that can be buffered in memory for network operations. Adjusted for 16GB RAM.
    "net.core.wmem_default" = 262144;           # Default socket send buffer size, improve network performance & applications that use sockets. Adjusted for 16GB RAM.
    "net.core.wmem_max" = 33554432;             # Maximum socket send buffer size, determine the amount of data that can be buffered in memory for network operations. Adjusted for 16GB RAM.
    "net.ipv4.ipfrag_high_threshold" = 5242880; # Reduce the chances of fragmentation. Adjusted for SSD.
    "net.ipv4.tcp_keepalive_intvl" = 30;        # TCP keepalive interval between probes to detect if a connection is still alive.
    "net.ipv4.tcp_keepalive_probes" = 5;        # TCP keepalive probes to detect if a connection is still alive.
    "net.ipv4.tcp_keepalive_time" = 300;        # TCP keepalive interval in seconds to detect if a connection is still alive.
    "vm.dirty_background_bytes" = 134217728;    # 128 MB
    "vm.dirty_bytes" = 402653184;               # 384 MB
    "vm.min_free_kbytes" = 65536;               # Minimum free memory for safety (in KB), helping prevent memory exhaustion situations. Adjusted for 16GB RAM.
    "vm.swappiness" = 10;                       # Adjust how aggressively the kernel swaps data from RAM to disk. Lower values prioritize keeping data in RAM. Adjusted for 16GB RAM.
    "vm.vfs_cache_pressure" = 90;              # Adjust vfs_cache_pressure (0-1000) to manage memory used for caching filesystem objects. Adjusted for 16GB RAM.
    
    # Nobara Tweaks  
    "fs.aio-max-nr" = 1000000;                  # defines the maximum number of asynchronous I/O requests that can be in progress at a given time.     1048576
    "fs.inotify.max_user_watches" = 65536;      # sets the maximum number of file system watches, enhancing file system monitoring capabilities.       Default: 8192  TWEAKED: 524288
    "kernel.panic" = 5;                         # Reboot after 5 seconds on kernel panic                                                               Default: 0
    "kernel.pid_max" = 131072;                  # allows a large number of processes and threads to be managed                                         Default: 32768 TWEAKED: 4194304
  };

}
