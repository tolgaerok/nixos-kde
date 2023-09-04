{ ... }: {

  imports = [

    # Configuration for  intel gpu acceleration & tlp
    # ./tlp
    ./cpu-frequency
    ./intel-acceleration.nix
    
  ];
}