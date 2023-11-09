{ config, lib, ... }:

{
  services.plexmediaserver = {
    enable = true;
    libraries = [{
      name = "My Library";
      path = "/mnt/sambashare/DLNA/";
    }];
  };
}
