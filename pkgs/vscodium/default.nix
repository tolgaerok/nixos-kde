{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs;
      [
        (vscode-with-extensions.override {

          vscode = vscodium;

          vscode = vscode;

          vscodeExtensions = with vscode-extensions;
            [
              b4dm4n.vscode-nixpkgs-fmt
              bbenoist.nix
              bmalehorn.vscode-fish
              bodil.file-browser
              bungcip.better-toml
              codezombiech.gitignore
              davidanson.vscode-markdownlint
              donjayamanne.githistory
              editorconfig.editorconfig
              esbenp.prettier-vscode
              formulahendry.code-runner
              grapecity.gc-excelviewer
              jnoortheen.nix-ide
              mechatroner.rainbow-csv
              mhutchie.git-graph
              naumovs.color-highlight
              pkief.material-icon-theme
              scala-lang.scala
              scalameta.metals
              shardulm94.trailing-spaces
              shd101wyy.markdown-preview-enhanced
              skyapps.fish-vscode
              streetsidesoftware.code-spell-checker
              tyriar.sort-lines
              yzhang.markdown-all-in-one
            ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [{
              name = "language-julia";
              publisher = "julialang";
              version = "1.48.1";
              sha256 =
                "986d9e38e8ad54f424d65889eb8bbd20035298e863431a69da3ed5a72e1dcb54";
            }];
        })
      ];
  };
}
