{ pkgs, ... }: 
{
  # Add the required packages for iwd backend
  environment.systemPackages = with pkgs; [ 
    iwd 
    # iwd-tools 
  ];
}
