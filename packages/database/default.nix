{ pkgs, ... }: {

  # Database related

  environment = {
    systemPackages = with pkgs;
      with libsForQt5; [
        dbeaver
        pgmodeler
        sqlitebrowser
      ];
  };
}
