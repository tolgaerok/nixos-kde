{ config, pkgs, lib, ... }:

let

  mylist = pkgs.writeScriptBin "mylist" ''
  clear
  echo "My custom packages" | ${pkgs.cowsay}/bin/cowsay | ${pkgs.lolcat}/bin/lolcat
  echo "#---------------------------------------------------------------"
  echo ""
  echo "backup-nix          Rsync NIXOS folder to server              "
  echo "copy-backup-nix     Copy to server          "
  echo "create-smb-user     Create samba users and group          "
  echo "gitup               Upload to github                    "
  echo "make-executable     Make all .sh and nix in folder executable          "
  echo "mounter             Mount all /mnt                  "
  echo "my-nix              Personal nix commands                           "
  echo "mylist              List all custom pkgs created                "
  echo "perform_rsync       Perform home to server backup            "
  echo "unmounter           Un-mount all /mnt                "
  echo ""
  echo "#---------------------------------------------------------------"

  '';

in {

  #---------------------------------------------------------------------
  # Type: mylist in terminal to execute above bash script
  #---------------------------------------------------------------------

  environment.systemPackages = [ mylist ];
}
