{ pkgs, ... }: {

  environment = {
    systemPackages = with pkgs; [
      isoimagewriter
      keepassxc
      media-downloader
      testdisk-qt
      # ventoy
      ventoy-full          # ventoy   ventoy-persistent   ventoy-web   ventoy-plugson   ventoy-extend-persistent
    ];
  };
}
