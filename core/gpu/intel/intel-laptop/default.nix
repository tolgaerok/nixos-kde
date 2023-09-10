{ ... }: {

  imports = [

    # Configuration for  intel gpu acceleration & tlp

    #./cpu-frequency
    #./intel-acceleration.nix
    #./tlp
    ./HP-Folio-9470M/Eilite-Folio-9470M-HD-Intel-4000.nix
    ./laptop-packages

  ];
}
