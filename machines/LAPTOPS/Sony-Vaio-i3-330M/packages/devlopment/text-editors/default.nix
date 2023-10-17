{ pkgs, ... }: {

  # Text Editors and Utilities:
  environment = {
    systemPackages = with pkgs; [

      # Text Editors
      kate
      libkate
      libsForQt5.kate
      vim

    ];
  };
}
