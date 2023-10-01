{ pkgs, ... }: {

  # Development and Version Control:....

  environment = {
    systemPackages = with pkgs; [

      # Utilities

      direnv
      graalvm17-ce
      mosh
      nix-direnv
      nixfmt
      nixos-option
      # sublime4
      vscode # conflicts with vscode-with-extensions as this is just a stand alone
      vscode-extensions.mkhl.direnv
      vscode-extensions.brettm12345.nixfmt-vscode
      
    ];
  };
}
