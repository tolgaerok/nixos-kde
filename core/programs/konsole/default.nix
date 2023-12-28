{ config, lib, ... }:

#---------------------------------------------------------------------
# Aliases for Bash console (Konsole)
#---------------------------------------------------------------------

{
  programs = {
    # command-not-found.enable = false;

    # Add Konsole (bash) aliases
    bash = {
    
      # Add any custom bash shell or aliases here
      shellAliases = {

        #---------------------------------------------------------------------
        # Nixos related
        #---------------------------------------------------------------------
        
        # rbs2 =      "sudo nixos-rebuild switch -I nixos-config=$HOME/nixos/configuration.nix";
        garbage =     "sudo nix-collect-garbage --delete-older-than 7d";
        lgens =       "sudo nix-env --profile /nix/var/nix/profiles/system --list-generations";
        neu =         "sudo nix-env --upgrade";
        nopt =        "sudo nix-store --optimise";
        rbs =         "sudo nixos-rebuild switch";
        rebuild-all = "sudo nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot && sudo fstrim -av";
        switch =      "sudo nixos-rebuild switch -I nixos-config=$HOME/nixos/configuration.nix";

        #---------------------------------------------------------------------
        # Personal scripts
        #---------------------------------------------------------------------

        htos =        "sudo ~/scripts/MYTOOLS/scripts/Zysnc-Options/ZYSNC-HOME-TO-SERVER.sh";
        master =      "sudo ~/scripts/MYTOOLS/main.sh";
        mount =       "sudo ~/scripts/MYTOOLS/scripts/Mounting-Options/MOUNT-ALL.sh";
        mse =         "sudo ~/scripts/MYTOOLS/MAKE-SCRIPTS-EXECUTABLE.sh";
        mynix =       "sudo ~/scripts/MYTOOLS/scripts/COMMAN-NIX-COMMAND-SCRIPT/MyNixOS-commands.sh";         
        stoh =        "sudo ~/scripts/MYTOOLS/scripts/Zysnc-Options/ZYSNC-SERVER-TO-HOME.sh";
        trimgen =     "sudo ~/scripts/MYTOOLS/scripts/GENERATION-TRIMMER/TrimmGenerations.sh";
        umount =      "sudo ~/scripts/MYTOOLS/scripts/Mounting-Options/UMOUNT-ALL.sh";
                
        #---------------------------------------------------------------------
        # Navigate files and directories
        #---------------------------------------------------------------------
        
        # cd = "cd ..";
        CL =    "source ~/.bashrc";
        cl =    "clear && CL";
        cong =  "echo && sysctl net.ipv4.tcp_congestion_control && echo";
        copy =  "rsync -P";
        io =    "echo &&  cat /sys/block/sda/queue/scheduler && echo";
        la =    "lsd -a";
        ll =    "lsd -l";
        ls =    "lsd";
        lsla =  "lsd -la";
        trim =  "sudo fstrim -av";

        #---------------------------------------------------------------------
        # Fun stuff
        #---------------------------------------------------------------------

        icons = "sxiv -t $HOME/Pictures/icons";
        wp = "sxiv -t $HOME/Pictures/Wallpapers";

        #---------------------------------------------------------------------
        # File access
        #---------------------------------------------------------------------
        cp = "cp -riv";
        mkdir = "mkdir -vp";
        mv = "mv -iv";

        #---------------------------------------------------------------------
        # GitHub related
        #---------------------------------------------------------------------

        gitfix = "git fetch origin main && git diff --exit-code origin/main";

      };
    };
  };
}
