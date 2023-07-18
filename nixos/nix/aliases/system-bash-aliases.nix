{ config, pkgs, lib, ... }:

# Aliases for Bash console (Konsole)
{
  programs = {
    command-not-found.enable = false;

    # Add Konsole (bash) aliases
    bash = {
    #  enable = true;

      # Add any custom bash shell or aliases here
      shellAliases = {
        garbage =     "sudo nix-collect-garbage --delete-older-than 14d";
        htos =        "sudo ~/scripts/MYTOOLS/scripts/Zysnc-Options/ZYSNC-HOME-TO-SERVER.sh";
        lgens =       "sudo nix-env --profile /nix/var/nix/profiles/system --list-generations";
        master =      "sudo ~/scripts/MYTOOLS/main.sh";
        mount =       "sudo ~/scripts/MYTOOLS/scripts/Mounting-Options/MOUNT-ALL.sh";
        mse =         "sudo ~/scripts/MYTOOLS/MAKE-SCRIPTS-EXECUTABLE.sh";
        mynix =       "sudo ~/scripts/MYTOOLS/scripts/COMMAN-NIX-COMMAND-SCRIPT/MyNixOS-commands.sh";
        neu =         "sudo nix-env --upgrade";
        nopt =        "sudo nix-store --optimise";
        rbs =         "sudo nixos-rebuild switch";
        rebuild-all = "sudo nix-collect-garbage --delete-older-than 14d && sudo nixos-rebuild switch";
        stoh =        "sudo ~/scripts/MYTOOLS/scripts/Zysnc-Options/ZYSNC-SERVER-TO-HOME.sh";
        trimgen =     "sudo ~/scripts/MYTOOLS/scripts/GENERATION-TRIMMER/TrimmGenerations.sh";
        umount =      "sudo ~/scripts/MYTOOLS/scripts/Mounting-Options/UMOUNT-ALL.sh";
      };
    };
  };
}
