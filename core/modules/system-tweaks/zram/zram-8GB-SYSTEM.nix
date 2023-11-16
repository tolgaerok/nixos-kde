{ config, ... }:

{

  #---------------------------------------------------------------------
  # Enable memory compression for (8GB) system
  # Faster processing and less SSD usage
  #---------------------------------------------------------------------
  zramSwap.enable = true;
  zramSwap.memoryPercent = 35;

  # 8GB
  #zramSwap.memoryMax = 8589934592;

}