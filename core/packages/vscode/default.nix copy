{ pkgs, ... }: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      # bbenoist.nix
      catppuccin.catppuccin-vsc
      mkhl.direnv
      vscode-icons-team.vscode-icons
      #eww-yuck.yuck
    ];

    userSettings = {
      "update.mode" = "none";
      # "extensions.autoUpdate" = false; # This stuff fixes vscode freaking out when theres an update

      "editor.fontFamily" = "'Iosevka Comfy', 'SymbolsNerdFont', 'monospace', monospace";
      "editor.fontLigatures" = true;
      "editor.minimap.enabled" = true;
      "vsicons.dontShowNewVersionMessage" = true;
      "window.menuBarVisibility" = "toggle";
      "workbench.colorTheme" = "Catppuccin Mocha";
      "workbench.iconTheme" = "vscode-icons";

    };
  };
}
