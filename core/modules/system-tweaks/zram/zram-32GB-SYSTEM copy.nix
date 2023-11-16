{ config, ... }:

{

  #---------------------------------------------------------------------
  # Enable memory compression for (32GB) system
  # Faster processing and less SSD usage
  #---------------------------------------------------------------------
  zramSwap.enable = true;
  zramSwap.memoryPercent = 35;

  # 32GB
  #zramSwap.memoryMax = 34359738368;

}
