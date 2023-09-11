{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs;
    with libsForQt5; [
      # tools
      ark
      filelight
      kate
      kcalc
      kdiff3
      kgpg
      krename
      qttools
      quazip

      # integration
      kaccounts-integration
      kaccounts-providers
      # kio-gdrive
    ];
  };
}