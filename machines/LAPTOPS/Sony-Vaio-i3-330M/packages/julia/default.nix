{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [

      # Scientific computing
      julia
      
    ];
  };
}
