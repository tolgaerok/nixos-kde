{ config, pkgs, lib, ... }: {
  # Services Configuration

  services = {

    # Early OOM Killer

    earlyoom = {
      enable = true;          # Enable the early OOM (Out Of Memory) killer service.

      # Free Memory Threshold
      # Sets the point at which earlyoom will intervene to free up memory.

      # When free memory falls below 15%, earlyoom acts to prevent system slowdown or freezing.
      freeMemThreshold = 5;

      # Technical Explanation:
      # The earlyoom service monitors system memory and intervenes when free memory drops below the specified threshold.
      # It helps prevent system slowdowns and freezes by intelligently killing less important processes to free up memory.
      # In this configuration, it triggers when free memory is only 15% of total RAM.
      # Adjust the freeMemThreshold value based on your system's memory usage patterns.

      # source:   https://github.com/rfjakob/earlyoom
      
    };
  };
}
