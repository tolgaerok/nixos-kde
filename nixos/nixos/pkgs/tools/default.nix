{ pkgs, ... }: {

  environment = {
    systemPackages = with pkgs; [
      isoimagewriter
      keepassxc
      media-downloader
      testdisk-qt
      ventoy
    ];
  };
}
