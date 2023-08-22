{ pkgs, ... }: {

  # Development and Version Control:....

  environment = {
    systemPackages = with pkgs; [

      # Utilities
      # unstable.vscode-fhs
      direnv
      gh

      #Git related:
      # git
      git-extras
      git-my
      gitFull  # git git-jump git-upload-pack git-credential-libsecret git-receive-pack git-upload-archive git-cvsserver scalar git-shell gitk git-http-backend git-credential-netrc
      gitg
      gitlab

      graalvm17-ce
      mosh
      nix-direnv
      nixfmt
      nixos-option
      sublime4
      vscode    # conflicts with vscode-with-extensions as this is just a stand alone
      vscode-extensions.mkhl.direnv
      # vscode-with-extensions

    ];
  };
}
