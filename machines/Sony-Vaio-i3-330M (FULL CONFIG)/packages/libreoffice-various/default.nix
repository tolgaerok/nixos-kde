{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      # libreoffice
      # libreoffice-qt
      qownnotes
      zotero
    ];
  };
}
