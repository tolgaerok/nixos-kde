{ config, ... }:

# Control how and when data is written from memory to disk, which can have an impact on system performance and responsiveness.  
# useful for optimizing memory usage, disk writeback behavior, network settings, and other low-level kernel behaviors.

{
  boot.kernel.sysctl = {

    #---------------------------------------------------------------------
    #   SSD tweaks: Adjust settings for an SSD to optimize performance.
    #---------------------------------------------------------------------
    "vm.dirty_background_ratio" = "40";         # Set the ratio of dirty memory at which background writeback starts (5%). Adjusted for SSD.
    "vm.dirty_expire_centisecs" = "3000";       # Set the time at which dirty data is old enough to be eligible for writeout (6000 centiseconds). Adjusted for SSD.
    "vm.dirty_ratio" = "80";                    # Set the ratio of dirty memory at which a process is forced to write out dirty data (10%). Adjusted for SSD.
    "vm.dirty_time" = "0";                      # Disable dirty time accounting.
    "vm.dirty_writeback_centisecs" = "300";     # Set the interval between two consecutive background writeback passes (500 centiseconds).


  };
  
  #--------------------------------------------------------------------- 
  #   trim deleted blocks from ssd
  #---------------------------------------------------------------------
  services.fstrim.enable = true;


}

