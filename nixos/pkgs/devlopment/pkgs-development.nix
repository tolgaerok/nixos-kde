{ pkgs, ... }:
{
  # Development and Version Control:
  environment = {
    systemPackages = with pkgs; [
      gh
      gimp-with-plugins
      git
      git-extras
      graalvm17-ce
      mosh
      nix-direnv
      nixfmt
      nixos-option
    ];
  };
}
