{ config, ... }:

{

  #---------------------------------------------------------------------
  # Enable memory compression for (64GB) system
  # Faster processing and less SSD usage
  #---------------------------------------------------------------------
  zramSwap.enable = true;
  zramSwap.memoryPercent = 35;

  # 64GB
  #zramSwap.memoryMax = 68719476736;

}
