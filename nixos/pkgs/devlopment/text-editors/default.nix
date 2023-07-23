{ pkgs, ... }:
{
  # Text Editors and Utilities:
  environment = {
    systemPackages = with pkgs; [
      kate
      libkate
      libsForQt5.kate
      vim
      vscode
      vscode-extensions.mkhl.direnv
      vscode-with-extensions
      sublime4
    ];
  };
}
