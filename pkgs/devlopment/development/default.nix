{ pkgs, ... }: {

  # Development and Version Control:....

  environment = {
    systemPackages = with pkgs; [

      # Utilities
      # unstable.vscode-fhs
      direnv
      gh
      git
      git-extras
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
