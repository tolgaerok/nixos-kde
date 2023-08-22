{ pkgs, ... }: {

  environment = {
    systemPackages = with pkgs; [
      # ventoy
      isoimagewriter
      keepassxc
      media-downloader
      testdisk-qt
      ventoy-full          # ventoy   ventoy-persistent   ventoy-web   ventoy-plugson   ventoy-extend-persistent
    ];
  };
}
