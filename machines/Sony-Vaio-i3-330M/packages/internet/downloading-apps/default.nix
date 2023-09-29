{ pkgs, ... }: {

  # Downloading and Retrieving Files:

  environment = {
    systemPackages = with pkgs; [
      
      # Downloading Videos and Files
      clipgrab
      wget
      
    ];
  };
}
