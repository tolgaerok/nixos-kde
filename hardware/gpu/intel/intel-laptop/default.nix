{ ... }: {

  imports = [

    # Configuration for  intel gpu acceleration & tlp
    ./cpu-frequency
    ./intel-acceleration/test.nix
    ./tlp
    
  ];
}