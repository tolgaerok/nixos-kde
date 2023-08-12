let

  pkgs = import <nixpkgs> { };

in pkgs.runCommand "my-1st-derivation" { }

''
  echo This world is FUCKED badly !! > $out
''


# nix build --file ./e2.nix 
# cat result

