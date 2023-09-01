{ config, pkgs, ... }:


# Control how and when data is written from memory to disk, which can have an impact on system performance and responsiveness.  
# useful for optimizing memory usage, disk writeback behavior, network settings, and other low-level kernel behaviors.


# Kernel tweaks
{
  boot.kernel.sysctl = {
    "kernel.sysrq" = 1;                       # SysRQ for is rebooting their machine properly if it freezes: SOURCE: https://oglo.dev/tutorials/sysrq/index.html
    "net.core.rmem_default" = 16777216;       # Default socket receive buffer size, improve network performance & applications that use sockets
    "net.core.rmem_max" = 16777216;           # Maximum socket receive buffer size, determin the amount of data that can be buffered in memory for network operations
    "net.core.wmem_default" = 16777216;       # Default socket send buffer size, improve network performance & applications that use sockets
    "net.core.wmem_max" = 16777216;           # Maximum socket send buffer size, determin the amount of data that can be buffered in memory for network operations
    "net.ipv4.tcp_keepalive_intvl" = 30;      # TCP keepalive interval between probes, TCP keepalive probes, which are used to detect if a connection is still alive.
    "net.ipv4.tcp_keepalive_probes" = 5;      # TCP keepalive probes, TCP keepalive probes, which are used to detect if a connection is still alive.
    "net.ipv4.tcp_keepalive_time" = 300;      # TCP keepalive interval (seconds), TCP keepalive probes, which are used to detect if a connection is still alive.
    "vm.dirty_background_bytes" = 16777216;   # 16 MB data that has been modified in memory and needs to be written to disk
    "vm.dirty_bytes" = 50331648;              # 48 MB data that has been modified in memory and needs to be written to disk
    "vm.min_free_kbytes" = 65536;             # Minimum free memory for safety (in KB), can help prevent memory exhaustion situations
    "vm.swappiness" = 1;                      # how aggressively the kernel swaps data from RAM to disk. Lower values prioritize keeping data in RAM,
    "vm.vfs_cache_pressure" = 50;             # Adjust vfs_cache_pressure (0-1000), how the kernel reclaims memory used for caching filesystem objects
  };

}
# Values explained:
# "vm.vfs_cache_pressure" = 50; Adjust vfs_cache_pressure (0-1000)

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

# CALCULATIONS: ( Schooling )
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
