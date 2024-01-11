{ config,  ... }:

# Control how and when data is written from memory to disk, which can have an impact on system performance and responsiveness.  
# useful for optimizing memory usage, disk writeback behavior, network settings, and other low-level kernel behaviors.

{

  imports = [
   # ./extra.nix
  ];


  boot.kernel.sysctl = {

    #---------------------------------------------------------------------
    #   Network and memory-related optimizationss for desktop 28GB
    #---------------------------------------------------------------------
    "kernel.sysrq" = 1;                         # Enable SysRQ for rebooting the machine properly if it freezes. [Source](https://oglo.dev/tutorials/sysrq/index.html)
    "net.ipv4.ipfrag_high_threshold" = 6291456; # Reduce the chances of fragmentation. Adjusted for SSD.
    "vm.dirty_background_bytes" = 474217728;    # 128 MB + 300 MB + 400 MB = 828 MB (rounded to 474217728)
    "vm.dirty_bytes" = 742653184;               # 384 MB + 300 MB + 400 MB = 1084 MB (rounded to 742653184)

    # Nobara, Solus and Fedora Tweaks  
    "fs.aio-max-nr" = 1000000;                      # defines the maximum number of asynchronous I/O requests that can be in progress at a given time.     1048576
    "fs.file-max" = 67108864;                       # Maximum number of file handles the kernel can allocate (Default: 67108864)
    "fs.inotify.max_user_watches" = 524288;         # sets the maximum number of file system watches, enhancing file system monitoring capabilities.       Default: 8192  TWEAKED: 524288
    "kernel.nmi_watchdog" = 0;                      # Disable NMI watchdog
    "kernel.panic" = 5;                             # Reboot after 5 seconds on kernel panic                                                               Default: 0
    "kernel.pid_max" = 131072;                      # allows a large number of processes and threads to be managed                                         Default: 32768 TWEAKED: 4194304    
    "kernel.sched_autogroup_enabled" = 0;            # Disable automatic task grouping for better server performance
    "kernel.unprivileged_bpf_disabled" = 1;          # Disable unprivileged BPF
    "net.core.default_qdisc" = "fq_codel";           # Traffic control (QDisc) algorithm for network devices
    "net.core.netdev_max_backlog" = 32768;          # Maximum length of the input queue of a network device
    "net.core.optmem_max" = 65536;                  # Maximum ancillary buffer size allowed per socket
    "net.core.rmem_default" = 1048576;              # Default socket receive buffer size
    "net.core.rmem_max" = 16777216;                 # Maximum socket receive buffer size
    "net.core.somaxconn" = 65536;                   # Maximum listen queue backlog
    "net.core.wmem_default" = 1048576;              # Default socket send buffer size
    "net.core.wmem_max" = 16777216;                 # Maximum socket send buffer size
    "net.ipv4.conf.all.accept_redirects" = 0;       # Disable acceptance of all ICMP redirected packets
    "net.ipv4.conf.all.secure_redirects" = 0;       # Disable acceptance of secure ICMP redirected packets
    "net.ipv4.conf.all.send_redirects" = 0;         # Disable sending of all IPv4 ICMP redirected packets
    "net.ipv4.conf.default.accept_redirects" = 0;   # Disable acceptance of all ICMP redirected packets (default)
    "net.ipv4.conf.default.secure_redirects" = 0;   # Disable acceptance of secure ICMP redirected packets (default)
    "net.ipv4.conf.default.send_redirects" = 0;     # Disable sending of all IPv4 ICMP redirected packets (default)
    "net.ipv4.ip_forward" = 1;                      # Enable IP forwarding    
    "net.ipv4.tcp_dsack" = 1;                        # Enable Delayed SACK
    "net.ipv4.tcp_ecn" = 1;                          # Enable Explicit Congestion Notification (ECN)
    "net.ipv4.tcp_fastopen" = 3;                     # Enable TCP Fast Open with a queue of 3
    "net.ipv4.tcp_fin_timeout" = 25;                 # Time to hold socket in FIN-WAIT-2 state (seconds)
    "net.ipv4.tcp_keepalive_intvl" = 30;             # Time between individual TCP keepalive probes (seconds)
    "net.ipv4.tcp_keepalive_probes" = 7;             # Number of TCP keepalive probes
    "net.ipv4.tcp_keepalive_time" = 1200;            # Time before sending TCP keepalive probes (seconds)
    "net.ipv4.tcp_max_orphans" = 819200;            # Maximum number of TCP sockets not attached to any user file handle
    "net.ipv4.tcp_max_syn_backlog" = 20480;         # Maximum length of the listen queue for accepting new TCP connections
    "net.ipv4.tcp_max_tw_buckets" = 1440000;        # Maximum number of TIME-WAIT sockets
    "net.ipv4.tcp_mem" = "65536 1048576 16777216";  # TCP memory allocation limits
    "net.ipv4.tcp_mtu_probing" = 1;                 # Enable Path MTU Discovery
    "net.ipv4.tcp_notsent_lowat" = 16384;           # Minimum amount of data in the send queue below which TCP will send more data
    "net.ipv4.tcp_retries2" = 8;                    # Number of times TCP retransmits unacknowledged data segments for the second SYN on a connection initiation
    "net.ipv4.tcp_rmem" = "8192 1048576 16777216";  # TCP read memory allocation for network sockets
    "net.ipv4.tcp_sack" = 1;                        # Enable Selective Acknowledgment (SACK)
    "net.ipv4.tcp_slow_start_after_idle" = 0;       # Disable slow start after idle
    "net.ipv4.tcp_window_scaling" = 1;              # Enable TCP window scaling
    "net.ipv4.tcp_wmem" = "8192 1048576 16777216";  # TCP write memory allocation for network sockets
    "net.ipv4.udp_mem" = "65536 1048576 16777216";  # UDP memory allocation limits
    "net.ipv6.conf.all.accept_redirects" = 0;       # Disable acceptance of all ICMP redirected packets for IPv6
    "net.ipv6.conf.all.disable_ipv6" = 0;           # Enable IPv6
    "net.ipv6.conf.all.forwarding" = 1;             # Enable IPv6 packet forwarding
    "net.ipv6.conf.default.accept_redirects" = 0;   # Disable acceptance of all ICMP redirected packets for IPv6 (default)
    "net.ipv6.conf.default.disable_ipv6" = 0;       # Enable IPv6
    "net.unix.max_dgram_qlen" = 50;                 # Maximum length of the UNIX domain socket datagram queue    
    "vm.extfrag_threshold" = 100;                   # Fragmentation threshold for the kernel
    "vm.min_free_kbytes" = 65536;                   # Minimum free kilobytes
    "vm.mmap_min_addr" = 65536;                     # Minimum address allowed for a user-space mmap
    "vm.swappiness" = 10;                           # Swappiness parameter (tendency to swap out unused pages)
    "vm.vfs_cache_pressure" = 50;                   # Controls the tendency of the kernel to reclaim the memory used for caching of directory and inode objects

    "-net.ipv4.conf.default.rp_filter" = 2;
    "-net.ipv4.conf.default.accept_source_route" = 0;
    "-net.ipv4.conf.default.promote_secondaries" = 1;

  }; 


    # Already defined
    # "kernel.pty.max" = 24000;                         # Maximum number of pseudo-terminals (PTYs) in the system
    # "net.core.default_qdisc"="fq";              # sets the default queuing discipline for network traffic in the Linux kernel to Fair Queueing (fq).    
    # "net.core.netdev_max_backlog" = 300000;     # Help prevent packet loss during high traffic periods.
    # "net.core.rmem_default" = 524288;           # Default socket receive buffer size, improve network performance & applications that use sockets. Adjusted for 28GB RAM.
    # "net.core.rmem_max" = 33554432;             # Maximum socket receive buffer size, determine the amount of data that can be buffered in memory for network operations. Adjusted for 28GB RAM.
    # "net.core.wmem_default" = 524288;           # Default socket send buffer size, improve network performance & applications that use sockets. Adjusted for 28GB RAM.
    # "net.core.wmem_max" = 33554432;             # Maximum socket send buffer size, determine the amount of data that can be buffered in memory for network operations. Adjusted for 28GB RAM.
    # "net.ipv4.tcp_congestion_control" = "westwood";   # TCP congestion control algorithm
    # "net.ipv4.tcp_congestion_control"="westwood";
    # "net.ipv4.tcp_keepalive_intvl" = 30;        # TCP keepalive interval between probes to detect if a connection is still alive.
    # "net.ipv4.tcp_keepalive_probes" = 5;        # TCP keepalive probes to detect if a connection is still alive.
    # "net.ipv4.tcp_keepalive_time" = 300;        # TCP keepalive interval in seconds to detect if a connection is still alive.
    # "vm.dirty_background_ratio" = 5;                  # Percentage of system memory at which background writeback starts
    # "vm.min_free_kbytes" = 65536;               # Minimum free memory for safety (in KB), helping prevent memory exhaustion situations. Adjusted for 28GB RAM.
    # "vm.swappiness" = 1;                        # Adjust how aggressively the kernel swaps data from RAM to disk. Lower values prioritize keeping data in RAM. Adjusted for 28GB RAM.
    # "vm.vfs_cache_pressure" = 60;               # Adjust vfs_cache_pressure (0-1000) to manage memory used for caching filesystem objects. Adjusted for 28GB RAM.

} 

# -----------------------------------------------------------------
#     Summary of my configuration
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
