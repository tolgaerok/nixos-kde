{ pkgs, ... }:

# To list all installed vscode extension run in terminal:   
# code --list-extensions | xargs -L 1 echo code --install-extension

{
  environment = {
    systemPackages = with pkgs;
      [
        (vscode-with-extensions.override {
          vscode = vscode; # Use the regular VS Code package
          vscodeExtensions = with vscode-extensions;

            [
              aaron-bond.better-comments
              aaronduino.nix-lsp
              adam-bender.commit-message-editor
              agutierrezr.emmet-keybindings
              agutierrezr.vscode-essentials
              albert.TabOut
              alefragnani.project-manager
              AlvaroSannas.nix
              anteprimorac.html-end-tag-labels
              arrterian.nix-env-selector
              B4dM4n.nixpkgs-fmt
              bbenoist.Nix
              bbugh.change-color-format
              bmalehorn.shell-syntax
              bodil.file-browser
              brettm12345.nixfmt-vscode
              BriteSnow.vscode-toggle-quotes
              castello-dev.bash-snippets
              cheshirekow.cmake-format
              christian-kohler.npm-intellisense
              christian-kohler.path-intellisense
              cipchk.cssrem
              codezombiech.gitignore
              coolbear.systemd-unit-file
              DavidAnson.vscode-markdownlint
              DeepInThought.vscode-shell-snippets
              deerawan.vscode-faker
              dionmunk.vscode-notes
              discretegames.f5anything
              donjayamanne.git-extension-pack
              donjayamanne.githistory
              dzhavat.git-cheatsheet
              eamodio.gitlens
              ecmel.vscode-html-css
              EditorConfig.EditorConfig
              EdwinKofler.vscode-hyperupcall-pack-unix
              elves.elvish
              esbenp.prettier-vscode
              ExodiusStudios.comment-anchors
              felipecaputo.git-project-manager
              FernandoToledo.ft-extension-pack
              formulahendry.auto-close-tag
              formulahendry.auto-rename-tag
              foxundermoon.shell-format
              gio00.fish
              GitHub.codespaces
              GitHub.copilot
              GitHub.github-vscode-theme
              GitHub.remotehub
              github.vscode-github-actions
              GitHub.vscode-pull-request-github
              huizhou.githd
              inu1255.easy-snippet
              Isaac-Frank.myBeautify
              j3m.shell-script-tests
              jamesottaway.nix-develop
              jannek-aalto.shell-function-outline
              jasonlhy.hungry-delete
              jbockle.jbockle-format-files
              jeff-hykin.better-shellscript-syntax
              jnoortheen.nix-ide
              joyous-coder.shell-extension-pack
              L13RARY.l13-sh-snippets
              lacroixdavid1.vscode-format-context-menu
              lizebang.bash-extension-pack
              mads-hartmann.bash-ide-vscode
              martinring.nix
              McCarter.start-git-bash
              mgmcdermott.vscode-language-babel
              mhutchie.git-graph
              mikeburgh.xml-format
              mikestead.dotenv
              mkhl.direnv
              mohd-akram.vscode-html-format
              mrmlnc.vscode-duplicate
              mrmlnc.vscode-scss
              ms-dotnettools.csharp
              ms-dotnettools.vscode-dotnet-runtime
              ms-edgedevtools.vscode-edge-devtools
              ms-python.python
              ms-python.vscode-pylance
              ms-vscode-remote.remote-containers
              ms-vscode-remote.remote-ssh
              ms-vscode-remote.remote-ssh-edit
              ms-vscode.azure-repos
              ms-vscode.cmake-tools
              ms-vscode.cpptools
              ms-vscode.cpptools-extension-pack
              ms-vscode.cpptools-themes
              ms-vscode.makefile-tools
              ms-vscode.powershell
              ms-vscode.remote-explorer
              ms-vscode.remote-repositories
              ms-vscode.remote-server
              ms-vsliveshare.vsliveshare
              msjsdiag.debugger-for-chrome
              nidu.copy-json-path
              Nixer1337.nixware-lua-api-snippets
              pinage404.bash-extension-pack
              pinage404.nix-extension-pack
              piotrpalarz.vscode-gitignore-generator
              PKief.material-icon-theme
              pombadev.pbbs
              pomber.git-file-history
              redhat.vscode-yaml
              Remisa.shellman
              richie5um2.vscode-sort-json
              rifi2k.format-html-in-php
              ritwickdey.LiveServer
              rogalmic.bash-debug
              rpinski.shebang-snippets
              ryu1kn.partial-diff
              sburg.vscode-javascript-booster
              shakram02.bash-beautify
              sibiraj-s.vscode-scss-formatter
              spmeesseman.vscode-taskexplorer
              sugatoray.vscode-git-extension-pack
              sum-packer.shell-extension-summary
              tetradresearch.vscode-h2o
              TheNuProjectContributors.vscode-nushell-lang
              timonwong.shellcheck
              truman.autocomplate-shell
              trunk.io
              twxs.cmake
              Tyriar.sort-lines
              usernamehw.errorlens
              varharrie.import-beautify
              vincentc-afk.auto-completion-t4d-shell-ansible
              VisualStudioExptTeam.intellicode-api-usage-examples
              VisualStudioExptTeam.vscodeintellicode
              vivaxy.vscode-conventional-commits
              vsls-contrib.gistfs
              waderyan.gitblame
              wmaurer.change-case
              wmaurer.vscode-jumpy
              xabikos.JavaScriptSnippets
              yamajyn.commandlist
              yasht.terminal-all-in-one
              yzhang.markdown-all-in-one
              ziyasal.vscode-open-in-github
            ];
        })
      ];
  };
}