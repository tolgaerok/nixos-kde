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
      # kio-gdrive
      # kaccounts-integration
      # kaccounts-providers
    ];
  };
}