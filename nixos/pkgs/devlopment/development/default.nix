{ pkgs, ... }: {

  # Development and Version Control:

  environment = {
    systemPackages = with pkgs; [

      # Utilities
      # unstable.vscode-fhs
      gh
      git
      git-extras
      graalvm17-ce
      mosh
      nix-direnv
      nixfmt
      nixos-option
      sublime4
      vscode
      vscode-extensions.mkhl.direnv
      vscode-with-extensions

    ];
  };
}
