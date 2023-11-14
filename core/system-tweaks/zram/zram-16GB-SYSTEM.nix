{ config, ... }:

{

  #---------------------------------------------------------------------
  # Enable memory compression for (16GB) system
  # Faster processing and less SSD usage
  #---------------------------------------------------------------------
  zramSwap.enable = true;
  zramSwap.memoryPercent = 35;

  # 16GB
  #zramSwap.memoryMax = 17179869184;

}
