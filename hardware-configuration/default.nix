{ ... }: {

  imports = [

    # Configuration for  HardwaRE on current system
    ./boot
    ./network
    ./nvidia-opengl
  ];
}