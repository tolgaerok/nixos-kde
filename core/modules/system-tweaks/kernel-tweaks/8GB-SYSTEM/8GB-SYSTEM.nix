{ config,  ... }:

# Control how and when data is written from memory to disk, which can have an impact on system performance and responsiveness.
# useful for optimizing memory usage, disk writeback behavior, network settings, and other low-level kernel behaviors.

{
  boot.kernel.sysctl = {

    #---------------------------------------------------------------------
    #   Network and memory-related optimizationss for 8GB
    #---------------------------------------------------------------------
    "kernel.sysrq" = 1;                         # Enable SysRQ for rebooting the machine properly if it freezes. [Source](https://oglo.dev/tutorials/sysrq/index.html)
    "net.core.netdev_max_backlog" = 30000;      # Help prevent packet loss during high traffic periods.
    "net.core.rmem_default" = 262144;           # Default socket receive buffer size, improve network performance & applications that use sockets. Adjusted for 8GB RAM.
    "net.core.rmem_max" = 33554432;             # Maximum socket receive buffer size, determine the amount of data that can be buffered in memory for network operations. Adjusted for 8GB RAM.
    "net.core.wmem_default" = 262144;           # Default socket send buffer size, improve network performance & applications that use sockets. Adjusted for 8GB RAM.
    "net.core.wmem_max" = 33554432;             # Maximum socket send buffer size, determine the amount of data that can be buffered in memory for network operations. Adjusted for 8GB RAM.
    "net.ipv4.ipfrag_high_threshold" = 5242880; # Reduce the chances of fragmentation. Adjusted for SSD.
    "net.ipv4.tcp_keepalive_intvl" = 30;        # TCP keepalive interval between probes to detect if a connection is still alive.
    "net.ipv4.tcp_keepalive_probes" = 5;        # TCP keepalive probes to detect if a connection is still alive.
    "net.ipv4.tcp_keepalive_time" = 300;        # TCP keepalive interval in seconds to detect if a connection is still alive.
    "vm.dirty_background_bytes" = 134217728;    # 128 MB
    "vm.dirty_bytes" = 402653184;               # 384 MB
    "vm.min_free_kbytes" = 131072;              # Minimum free memory for safety (in KB), helping prevent memory exhaustion situations. Adjusted for 8GB RAM.
    "vm.swappiness" = 10;                        # Adjust how aggressively the kernel swaps data from RAM to disk. Lower values prioritize keeping data in RAM. Adjusted for 8GB RAM.
    "vm.vfs_cache_pressure" = 90;               # Adjust vfs_cache_pressure (0-1000) to manage memory used for caching filesystem objects. Adjusted for 8GB RAM.

    # Nobara Tweaks  
    "fs.aio-max-nr" = 1000000;                  # defines the maximum number of asynchronous I/O requests that can be in progress at a given time.     1048576
    "fs.inotify.max_user_watches" = 65536;      # sets the maximum number of file system watches, enhancing file system monitoring capabilities.       Default: 8192  TWEAKED: 524288
    "kernel.panic" = 5;                         # Reboot after 5 seconds on kernel panic                                                               Default: 0
    "kernel.pid_max" = 131072;                  # allows a large number of processes and threads to be managed                                         Default: 32768 TWEAKED: 4194304

  };

}

# -----------------------------------------------------------------
# Summary of my configuration
# -----------------------------------------------------------------

# Network Performance Settings:
# ----------------------------------------------
# "net.core.rmem_default" = 16 MB
# "net.core.rmem_max" = 16 MB
# "net.core.wmem_default" = 16 MB
# "net.core.wmem_max" = 16 MB
# These settings define the default and maximum socket buffer sizes for receiving and sending data, improving network performance and benefiting applications that use sockets.

# TCP Keepalive Settings:
# ----------------------------------------------
# "net.ipv4.tcp_keepalive_intvl" = 30 seconds
# "net.ipv4.tcp_keepalive_probes" = 5 probes
# "net.ipv4.tcp_keepalive_time" = 300 seconds
# These settings configure TCP keepalive parameters, which are used to detect if a network connection is still alive.

# Disk Write Behavior Settings:
# ----------------------------------------------
# "vm.dirty_background_bytes" = 16 MB
# "vm.dirty_bytes" = 48 MB
# These settings control how much modified data in memory needs to be written to disk. Lower values can lead to more frequent writes.

# Memory Safety Setting:
# ----------------------------------------------
# "vm.min_free_kbytes" = 65,536 KB
# This setting specifies the minimum amount of free memory in kilobytes, helping to prevent memory exhaustion situations.

# Swappiness Setting:
# ----------------------------------------------
# "vm.swappiness" = 1
# This setting determines how aggressively the kernel swaps data from RAM to disk. Lower values prioritize keeping data in RAM, suitable for systems with ample memory.

# Cache Pressure Setting:
# ----------------------------------------------
# "vm.vfs_cache_pressure" = 50
# This setting adjusts vfs_cache_pressure (0-1000), influencing how the kernel reclaims memory used for caching filesystem objects.

# Customize these settings based on your system's requirements and performance goals, check below for extra info.

# Values explained:
# "vm.vfs_cache_pressure" = 50; Adjust vfs_cache_pressure (0-1000)
# -----------------------------------------------------------------
# 4GB RAM:  50 - 60 [ Lower values like 50 or 60 can be a good starting point for systems with 4GB of RAM to retain data in cache for improved file system access times ]
# 8GB RAM:  60 - 80 [ Values around 60 to 80 are reasonable for 8GB of RAM, as you can still afford to keep more data in cache for better performance ]
# 16GB RAM: 70 - 80 [ Lower values like 70 or 80 can be used to keep data in cache longer for systems with 16GB of RAM ]
# 32GB RAM: 80 - 90 [ Values around 80 or 90 are suitable for systems with 32GB of RAM, allowing more data to stay in cache ]
# 64GB RAM or More: 90 - 100 [ Lower values like 90 or 100 can minimize cache eviction for systems with very high memory, such as 64GB or more ]

# Low Values (e.g., 10-100):
# Situations where you have a lot of available RAM.
# When you want to optimize filesystem access times by keeping more data in cache.
# Systems with large file datasets that can benefit from a larger cache.

# High Values (e.g., 500-1000):
# Systems with limited RAM resources.
# Servers or virtual machines where memory availability is critical.
# When you want to ensure that cached memory is released more aggressively for other applications.

# vm.swappiness = <Recommended Value>
# ----------------------------------------------
# Adjusts how aggressively the kernel swaps data from RAM to disk.
# - For systems with 4GB RAM, consider a low value (1-10) to prioritize keeping data in RAM.
# - For systems with 8GB RAM, use a moderate value (10-30) for a balance between RAM usage and swapping.
# - For systems with 16GB to 28GB RAM, aim for a moderate value (10-30) to optimize performance.
# - For systems with 32GB or more RAM, a slightly higher value (30-60) may be suitable.
# Monitor system performance and adjust as needed based on your workload and available RAM.

# CALCULATIONS: ( Schooling )
# ----------------------------------------------
# 1 MB (megabyte) = 1048576 bytes
# To convert bytes to megabytes, divide the number of bytes by 1048576.

# Here's how the calculations work for the values provided:
# For "vm.dirty_background_bytes":
# 16777216 bytes ÷ 1048576 bytes/MB = 16 MB

# For "vm.dirty_bytes":
# 50331648 bytes ÷ 1048576 bytes/MB = 48 MB

# These calculations provide the approximate size in megabytes for the specified values.

# The values "vm.dirty_background_bytes" and "vm.dirty_bytes" control how much dirty data (data that has been modified but not yet written to disk)
# can accumulate in the system's cache before it's flushed to disk. Lowering these values, as done here, results in more frequent disk writes,
# which can be useful when you need data to be quickly written to a USB drive.

