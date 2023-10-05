{
  config,
  pkgs,
  lib,
  ...
}: {
  hardware = {
    bluetooth = {
      enable = true;
    };
  };
}
