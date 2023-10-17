{ pkgs, ... }: 
{
  # Programming Languages and Tools:
  environment = {
    systemPackages = with pkgs; [
      scala-cli
      python311Full   # idle3.11 python3.11-config idle python3-config pydoc pydoc3 pydoc3.11 idle3 2to3-3.11 2to3 python3.11 python3 python-config python
    ];
  };
}
