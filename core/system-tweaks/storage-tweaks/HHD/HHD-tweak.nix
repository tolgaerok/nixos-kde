{ config, ... }:

# Control how and when data is written from memory to disk, which can have an impact on system performance and responsiveness.  
# useful for optimizing memory usage, disk writeback behavior, network settings, and other low-level kernel behaviors.

{
  boot.kernel.sysctl = {

    #---------------------------------------------------------------------
    # HDD tweaks: Adjust settings for an HDD to optimize performance.
    #---------------------------------------------------------------------
    "vm.dirty_background_ratio" = "10";       # Set the ratio of dirty memory at which background writeback starts (10% for HDD).
    "vm.dirty_expire_centisecs" = "6000";     # Set the time at which dirty data is old enough to be eligible for writeout (6000 centiseconds for HDD).
    "vm.dirty_ratio" = "20";                  # Set the ratio of dirty memory at which a process is forced to write out dirty data (20% for HDD).
    "vm.dirty_time" = "0";                    # Disable dirty time accounting.
    "vm.dirty_writeback_centisecs" = "1000";  # Set the interval between two consecutive background writeback passes (1000 centiseconds for HDD).

  };
}
