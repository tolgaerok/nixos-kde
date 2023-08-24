{ ... }: {

  imports = [

    # Configuration for  HardwaRE on current system
    ./fstab
    ./network
    ./nvidia-opengl
  ];
}