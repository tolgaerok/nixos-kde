{ pkgs, ... }: {

  # Development and Version Control:

  environment = {
    systemPackages = with pkgs; [

      # Utilities
      gh
      git
      git-extras
      graalvm17-ce
      mosh
      nix-direnv
      nixfmt
      nixos-option
      vscode
      vscode-extensions.mkhl.direnv
      vscode-with-extensions
      # unstable.vscode-fhs
      sublime4

    ];
  };
}
