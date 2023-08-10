{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs;
      [

        # Scanning

        gnome.simple-scan

      ];
  };
}
