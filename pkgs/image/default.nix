{ pkgs, ... }: {

  # Image Scanning and Processing:

  environment = {
    systemPackages = with pkgs; [

      # Scanning and Image Viewing
      nsxiv
      sane-backends
      scanbd
      sxiv
      
    ];
  };
}
