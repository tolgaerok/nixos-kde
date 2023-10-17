{ config, pkgs, lib, ... }: {

  # Environments for Database

  environment = {

    unixODBCDrivers = with pkgs;
      with unixODBCDrivers; [

        mariadb
        psql
        sqlite

      ];
  };
}
