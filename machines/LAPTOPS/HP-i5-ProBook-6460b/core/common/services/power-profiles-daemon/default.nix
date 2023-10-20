{
  config,
  pkgs,
  lib,
  ...
}: {
  services = {
    power-profiles-daemon = {
      enable = false;
    };
  };
}
