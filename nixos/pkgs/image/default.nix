{ pkgs, ... }: {

  # Image Scanning and Processing:

  environment = {
    systemPackages = with pkgs; [

      # Scanning and Image Viewing
      sane-backends
      scanbd
      sxiv
      nsxiv
      
    ];
  };
}
