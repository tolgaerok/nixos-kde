{ pkgs, ... }: 
{
  # Programming Languages and Tools:
  environment = {
    systemPackages = with pkgs; [
      scala-cli
    ];
  };
}
