{ pkgs, ... }: {

  # Development and Version Control:....

  environment = {
    systemPackages = with pkgs; [

      # Utilities
      # unstable.vscode-fhs
      direnv
      gh

      #Git related
      git
      git-extras
      git-my
      gitFull
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
