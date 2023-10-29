{ pkgs, config, lib, ... }:

#---------------------------------------------------------------------
# Steam related packages and settings
#---------------------------------------------------------------------

{
  nixpkgs = {
    config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) [ "steam" "steam-original" "steam-run" ];

    overlays = [
      (final: prev: {
        steam = prev.steam.override ({ extraPkgs ? pkgs': [ ], ... }: {
          extraPkgs = pkgs': (extraPkgs pkgs') ++ (with pkgs'; [ libgdiplus ]);
        });
      })
    ];
  };

  environment.systemPackages = with pkgs; [ steam vulkan-headers ntfs3g ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall =
      true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall =
      true; # Open ports in the firewall for Source Dedicated Server
  };
}

