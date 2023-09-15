{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      # libreoffice-fresh
      # libreoffice-qt
      qownnotes
      zotero
    ];
  };
}
