{
  config,
  pkgs,
  lib,
  ...
}: {
  services = {
    thermald = {
      enable = false;
    };
  };
}
