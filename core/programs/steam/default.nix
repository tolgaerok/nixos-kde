{ options, pkgs, config, lib, ... }:

#---------------------------------------------------------------------
# Steam related packages and settings
#---------------------------------------------------------------------

with lib;
with lib.my;
let cfg = config.modules.desktop.gaming.steam;

in {
  
  hardware.steam-hardware.enable = true;

  options.modules.desktop.gaming.steam = with types; {
    enable = mkBoolOpt false;
  };

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

  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall =
        true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall =
        true; # Open ports in the firewall for Source Dedicated Server

      # better for steam proton games
      systemd.extraConfig = "DefaultLimitNOFILE=1048576";
    };
  };

  services.jack.alsa.support32Bit = true;
  services.pipewire.alsa.support32Bit = true;

}

