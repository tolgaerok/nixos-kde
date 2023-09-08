{ config, pkgs, lib, ... }:

let

  mylist = pkgs.writeScriptBin "mylist" ''
  clear
  echo "My custom packages" | ${pkgs.cowsay}/bin/cowsay | ${pkgs.lolcat}/bin/lolcat
  echo "#---------------------------------------------------------------" | ${pkgs.lolcat}/bin/lolcat
  echo ""
  echo "backup-nix          Rsync NIXOS folder to server" | ${pkgs.lolcat}/bin/lolcat
  echo "copy-backup-nix     Copy to server" | ${pkgs.lolcat}/bin/lolcat
  echo "create-smb-user     Create samba users and group" | ${pkgs.lolcat}/bin/lolcat
  echo "gitup               Upload to github" | ${pkgs.lolcat}/bin/lolcat
  echo "make-executable     Make all .sh and nix in folder executable" | ${pkgs.lolcat}/bin/lolcat
  echo "mounter             Mount all /mnt" | ${pkgs.lolcat}/bin/lolcat
  echo "my-nix              Personal nix commands" | ${pkgs.lolcat}/bin/lolcat
  echo "mylist              List all custom pkgs created" | ${pkgs.lolcat}/bin/lolcat
  echo "perform_rsync       Perform home to server backup" | ${pkgs.lolcat}/bin/lolcat
  echo "unmounter           Un-mount all /mnt" | ${pkgs.lolcat}/bin/lolcat
  echo ""
  echo "#---------------------------------------------------------------" | ${pkgs.lolcat}/bin/lolcat

  echo "Your nix info:"
  echo "#---------------------------------------------------------------" | ${pkgs.lolcat}/bin/lolcat
  nix-shell -p nix-info --run 'nix-info -m' 

  echo "Your list of generations:"
  echo "#---------------------------------------------------------------" | ${pkgs.lolcat}/bin/lolcat
  sudo nix-env -p /nix/var/nix/profiles/system --list-generations
  


'';

in {

  #---------------------------------------------------------------------
  # Type: mylist in terminal to execute above bash script
  #---------------------------------------------------------------------

  environment.systemPackages = [ mylist ];
}
