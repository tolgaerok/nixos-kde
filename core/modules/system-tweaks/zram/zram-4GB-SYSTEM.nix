{ config, ... }:

{

  #---------------------------------------------------------------------
  # Enable memory compression for (4GB) system
  # Faster processing and less SSD usage
  #---------------------------------------------------------------------
  zramSwap.enable = true;
  zramSwap.memoryPercent = 20;

  # 4GB
  zramSwap.memoryMax = 4294967296;

}
