{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      dvc
      gnuplot
      iredis
      litecli
      luigi
      mpi
      quarto
      root
      visidata
    ];
  };
}
