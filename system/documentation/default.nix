{
  config,
  pkgs,
  lib,
  ...
}: {
  documentation = {
    doc.enable = false;
    info.enable = false;
    nixos.enable = false;
  };
}
