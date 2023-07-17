{ config, pkgs, lib, ... }:

# Nix-specific settings and garbage collection options - Mostly research from NixOS wiki
let 

name = "tolga";


in {
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      sandbox = true;
      trusted-users = [ "root" "${name}" ];
      warn-dirty = false;
      allowed-users = [ "@wheel" ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--max-freed 1G --delete-older-than 7d";
    };
  };

# Use aliases in FISH & Bash console (Konsole)
  programs = {
    command-not-found.enable = false;
    # enable = true;
    
    # Add Konsole (bash) aliases
    bash = {      
      # enable = true;
      shellAliases = {

        # Testing purposes 
        abc = "sudo nixos-rebuild switch";

      };
    };

    # Add Fish aliases
    fish = {
      enable = true;

      # Add any custom fish shell initialization commands here
      interactiveShellInit = ''
        set fish_cursor_default block blink
        set fish_cursor_insert line blink
        set fish_cursor_replace_one underscore blink
        set fish_cursor_visual block
        set -U fish_color_autosuggestion brblack
        set -U fish_color_cancel -r
        set -U fish_color_command green
        set -U fish_color_comment brblack
        set -U fish_color_cwd brgreen
        set -U fish_color_cwd_root brred
        set -U fish_color_end brmagenta
        set -U fish_color_error red
        set -U fish_color_escape brcyan
        set -U fish_color_history_current --bold
        set -U fish_color_host normal
        set -U fish_color_match --background=brblue
        set -U fish_color_normal normal
        set -U fish_color_operator cyan
        set -U fish_color_param blue
        set -U fish_color_quote yellow
        set -U fish_color_redirection magenta
        set -U fish_color_search_match bryellow '--background=brblack'
        set -U fish_color_selection white --bold '--background=brblack'
        set -U fish_color_status red
        set -U fish_color_user brwhite
        set -U fish_color_valid_path --underline
        set -U fish_pager_color_completion normal
        set -U fish_pager_color_description yellow
        set -U fish_pager_color_prefix white --bold --underline
        set -U fish_pager_color_progress brwhite '--background=cyan'
      '';

      # Fish shellAbbrs
      shellAbbrs = {
        garbage = "sudo nix-collect-garbage --delete-older-than 14d";
        rebuild-all = "sudo nix-collect-garbage --delete-older-than 14d && sudo nixos-rebuild switch";
        rbs = "sudo nixos-rebuild switch";
      };

      # Fish aliases
      shellAliases = {
        mynix = "sudo ~/scripts/MYTOOLS/scripts/COMMAN-NIX-COMMAND-SCRIPT/MyNixOS-commands.sh";
        mount = "sudo ~/scripts/MYTOOLS/scripts/Mounting-Options/MOUNT-ALL.sh";
        umount = "sudo ~/scripts/MYTOOLS/scripts/Mounting-Options/UMOUNT-ALL.sh";
        mse = "sudo ~/scripts/MYTOOLS/MAKE-SCRIPTS-EXECUTABLE.sh";
        htos = "sudo ~/scripts/MYTOOLS/scripts/Zysnc-Options/ZYSNC-HOME-TO-SERVER.sh";
        stoh = "sudo ~/scripts/MYTOOLS/scripts/Zysnc-Options/ZYSNC-SERVER-TO-HOME.sh";
        trimgen = "sudo ~/scripts/MYTOOLS/scripts/GENERATION-TRIMMER/TrimmGenerations.sh";
        master = "sudo ~/scripts/MYTOOLS/main.sh";
      };
    };
  };
}
