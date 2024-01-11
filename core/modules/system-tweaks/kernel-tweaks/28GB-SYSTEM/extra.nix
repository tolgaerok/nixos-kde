{ config,  ... }:

# Control how and when data is written from memory to disk, which can have an impact on system performance and responsiveness.  
# useful for optimizing memory usage, disk writeback behavior, network settings, and other low-level kernel behaviors.

{

boot.kernel.sysctl."90-override" = {
  net.ipv4.conf.all.rp_filter = builtins.trace "rp_filter: " 2;
  net.ipv4.conf.all.accept_source_route = builtins.trace "accept_source_route: " 0;
  net.ipv4.conf.all.promote_secondaries = builtins.trace "promote_secondaries: " 1;
};


}