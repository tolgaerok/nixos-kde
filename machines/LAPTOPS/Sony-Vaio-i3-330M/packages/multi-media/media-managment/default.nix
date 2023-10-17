{ pkgs, ... }: {

  # Media Management:
  environment = {
    systemPackages = with pkgs; [

      # Picture manger
      digikam
      shotwell

      # Picture Editors
      gimp-with-plugins

      # Disc burner
      brasero

    ];
  };
}
